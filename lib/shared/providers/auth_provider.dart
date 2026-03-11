import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

part 'auth_provider.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    AppUser? user,
    String? error,
  }) = _AuthState;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState());

  Future<void> tryRestoreSession() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final restored = await _authService.tryRestoreSession();
      if (restored) {
        final user = await _authService.getMe();
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loginWithGoogle(String googleIdToken) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _authService.loginWithGoogle(googleIdToken);
      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register({
    required String googleIdToken,
    required String name,
    String? branchId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _authService.register(
        googleIdToken: googleIdToken,
        name: name,
        branchId: branchId,
      );
      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.logout();
    } catch (_) {
      // Ignore logout errors
    }
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
