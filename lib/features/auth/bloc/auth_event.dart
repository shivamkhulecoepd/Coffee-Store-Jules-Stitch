import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

// ─── Initialization ─────────────────────────────────────────────────────────

class InitAuthEvent extends AuthEvent {}

class SelectRoleEvent extends AuthEvent {
  final UserRole role;
  const SelectRoleEvent(this.role);
  @override
  List<Object?> get props => [role];
}

// ─── Registration ────────────────────────────────────────────────────────────

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserRole role;
  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
  @override
  List<Object?> get props => [name, email, password, role];
}

// ─── Login / Logout ──────────────────────────────────────────────────────────

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}

// ─── OTP Flow ────────────────────────────────────────────────────────────────

class SendOtpEvent extends AuthEvent {
  final String email;
  const SendOtpEvent(this.email);
  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;
  const VerifyOtpEvent({required this.email, required this.otp});
  @override
  List<Object?> get props => [email, otp];
}

// ─── Password Reset ─────────────────────────────────────────────────────────

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;
  const ResetPasswordEvent({required this.email, required this.newPassword});
  @override
  List<Object?> get props => [email, newPassword];
}
