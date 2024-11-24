part of 'auth_cubit.dart';

final class AuthState {
  final bool needShowAuthError;
  final bool needShowLoading;

  const AuthState({
    this.needShowAuthError = false,
    this.needShowLoading = false,
  });

  AuthState copyWith({
    bool? needShowAuthError,
    bool? needShowLoading,
  }) {
    return AuthState(
      needShowAuthError: needShowAuthError ?? this.needShowAuthError,
      needShowLoading: needShowLoading ?? this.needShowLoading,
    );
  }
}
