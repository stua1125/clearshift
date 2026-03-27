import axios from "axios";

const apiClient = axios.create({
  baseURL: "/api",
  headers: { "Content-Type": "application/json" },
});

// Request: JWT 자동 주입
apiClient.interceptors.request.use((config) => {
  if (typeof window === "undefined") return config;

  const stored = localStorage.getItem("auth-storage");
  if (stored) {
    try {
      const { state } = JSON.parse(stored);
      if (state?.accessToken) {
        config.headers.Authorization = `Bearer ${state.accessToken}`;
      }
    } catch {
      // ignore parse errors
    }
  }
  return config;
});

// Response: 401 → refresh 시도, 403 → 그대로 reject (권한 부족)
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    const status = error.response?.status;

    // 403 Forbidden — 권한 부족이므로 리다이렉트하지 않고 에러 전파
    if (status === 403) {
      return Promise.reject(error);
    }

    // 401 Unauthorized — 토큰 만료 시 refresh 시도
    if (status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;

      try {
        const stored = localStorage.getItem("auth-storage");
        if (!stored) throw new Error("No auth storage");

        const { state } = JSON.parse(stored);
        if (!state?.refreshToken) throw new Error("No refresh token");

        const { data } = await axios.post("/api/auth/refresh", {
          refreshToken: state.refreshToken,
        });

        // Update stored tokens
        const updated = {
          state: {
            ...state,
            accessToken: data.accessToken,
            refreshToken: data.refreshToken,
          },
        };
        localStorage.setItem("auth-storage", JSON.stringify(updated));

        originalRequest.headers.Authorization = `Bearer ${data.accessToken}`;
        return apiClient(originalRequest);
      } catch {
        localStorage.removeItem("auth-storage");
        if (typeof window !== "undefined") {
          window.location.href = "/auth";
        }
        return Promise.reject(error);
      }
    }

    return Promise.reject(error);
  }
);

export default apiClient;
