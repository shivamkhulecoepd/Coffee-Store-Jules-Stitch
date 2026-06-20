import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class SelectRoleEvent extends AuthEvent {
  final String role;
  const SelectRoleEvent(this.role);
  @override
  List<Object> get props => [role];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
