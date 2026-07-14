import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  otpSent,
  otpVerified,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final UserRole? selectedRole;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.selectedRole,
    this.errorMessage,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  bool get isLoading => status == AuthStatus.loading;

  String get landingRoute => user?.landingRoute ?? '/welcome';

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    UserRole? selectedRole,
    String? errorMessage,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      selectedRole: selectedRole ?? this.selectedRole,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, selectedRole, errorMessage];
}
