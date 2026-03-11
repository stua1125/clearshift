import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final String baseUrl;
  final HttpClient _httpClient;

  String? _accessToken;
  String? _refreshToken;
  bool _isRefreshing = false;

  ApiClient({this.baseUrl = 'http://localhost:8080'})
      : _httpClient = HttpClient() {
    _httpClient.connectionTimeout = const Duration(seconds: 10);
  }

  bool get hasToken => _accessToken != null;

  Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(_accessTokenKey);
    _refreshToken = prefs.getString(_refreshTokenKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  Future<Map<String, dynamic>> get(String path) async {
    return _request('GET', path);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    return _request('POST', path, body: body);
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    return _request('PUT', path, body: body);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    return _request('DELETE', path);
  }

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool isRetry = false,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final request = await _openRequest(method, uri);

    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.acceptHeader, 'application/json');

    if (_accessToken != null) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $_accessToken');
    }

    if (body != null) {
      request.write(jsonEncode(body));
    }

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    final statusCode = response.statusCode;

    if (statusCode == 401 && !isRetry && !_isRefreshing) {
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        return _request(method, path, body: body, isRetry: true);
      }
    }

    if (statusCode < 200 || statusCode >= 300) {
      String message;
      try {
        final decoded = jsonDecode(responseBody) as Map<String, dynamic>;
        message = decoded['message'] as String? ?? responseBody;
      } catch (_) {
        message = responseBody.isNotEmpty ? responseBody : 'Request failed';
      }
      throw ApiException(statusCode: statusCode, message: message);
    }

    if (responseBody.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(responseBody);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    return {'data': decoded};
  }

  Future<HttpClientRequest> _openRequest(String method, Uri uri) async {
    switch (method) {
      case 'GET':
        return _httpClient.getUrl(uri);
      case 'POST':
        return _httpClient.postUrl(uri);
      case 'PUT':
        return _httpClient.putUrl(uri);
      case 'DELETE':
        return _httpClient.deleteUrl(uri);
      default:
        throw UnsupportedError('HTTP method $method is not supported');
    }
  }

  Future<bool> _tryRefreshToken() async {
    if (_refreshToken == null) return false;

    _isRefreshing = true;
    try {
      final uri = Uri.parse('$baseUrl/api/auth/refresh');
      final request = await _httpClient.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.write(jsonEncode({'refreshToken': _refreshToken}));

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        await saveTokens(
          accessToken: data['accessToken'] as String,
          refreshToken: data['refreshToken'] as String,
        );
        return true;
      }

      await clearTokens();
      return false;
    } catch (_) {
      return false;
    } finally {
      _isRefreshing = false;
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
