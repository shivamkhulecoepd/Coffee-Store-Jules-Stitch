import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? role;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.role,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? role,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      role: role ?? this.role,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, role, errorMessage];
}
