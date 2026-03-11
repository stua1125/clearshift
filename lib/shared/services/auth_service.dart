import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<AppUser> loginWithGoogle(String googleIdToken) async {
    final response = await _apiClient.post(
      '/api/auth/google',
      body: {'idToken': googleIdToken},
    );

    await _apiClient.saveTokens(
      accessToken: response['accessToken'] as String,
      refreshToken: response['refreshToken'] as String,
    );

    final userData = response['user'] as Map<String, dynamic>;
    return AppUser.fromJson(userData);
  }

  Future<AppUser> register({
    required String googleIdToken,
    required String name,
    String? branchId,
  }) async {
    final response = await _apiClient.post(
      '/api/auth/register',
      body: {
        'idToken': googleIdToken,
        'name': name,
        if (branchId case final id?) 'branchId': id,
      },
    );

    await _apiClient.saveTokens(
      accessToken: response['accessToken'] as String,
      refreshToken: response['refreshToken'] as String,
    );

    final userData = response['user'] as Map<String, dynamic>;
    return AppUser.fromJson(userData);
  }

  Future<AppUser> getMe() async {
    final response = await _apiClient.get('/api/auth/me');
    return AppUser.fromJson(response);
  }

  Future<void> refreshToken() async {
    // Token refresh is handled internally by ApiClient on 401 responses.
    // This method is exposed for explicit refresh if needed.
    await _apiClient.get('/api/auth/me');
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/api/auth/logout');
    } catch (_) {
      // Ignore server errors during logout
    } finally {
      await _apiClient.clearTokens();
    }
  }

  Future<bool> tryRestoreSession() async {
    await _apiClient.loadTokens();
    if (!_apiClient.hasToken) return false;

    try {
      await getMe();
      return true;
    } catch (_) {
      await _apiClient.clearTokens();
      return false;
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient);
});
