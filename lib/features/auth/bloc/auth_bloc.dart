import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Internal event for syncing bloc state with the repository stream.
class _AuthStreamChangedEvent extends AuthEvent {
  final User? user;
  const _AuthStreamChangedEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    // ⚠️ Register ALL handlers BEFORE calling add() — BLoC dispatches synchronously.
    on<InitAuthEvent>(_onInit);
    on<SelectRoleEvent>(_onSelectRole);
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordEvent>(_onResetPassword);
    on<_AuthStreamChangedEvent>(_onAuthStreamChanged);

    // Now safe to dispatch — handler is already registered.
    add(InitAuthEvent());

    // Keep bloc in sync with repository stream (e.g. logout from another screen)
    _authStateSubscription = _authRepository.authStateStream.listen((user) {
      add(_AuthStreamChangedEvent(user));
    });
  }

  void _onInit(InitAuthEvent event, Emitter<AuthState> emit) {
    // Sync repository state on startup
    if (_authRepository.currentUser != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: _authRepository.currentUser,
      ));
    }
  }

  void _onAuthStreamChanged(_AuthStreamChangedEvent event, Emitter<AuthState> emit) {
    if (event.user == null && state.status == AuthStatus.authenticated) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
    }
  }

  void _onSelectRole(SelectRoleEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(selectedRole: event.role));
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
      );
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Registration failed. Please try again.',
      ));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid email or password.',
      ));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.sendOtp(email: event.email);
      emit(state.copyWith(status: AuthStatus.otpSent));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Failed to send OTP. Please try again.',
      ));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final valid = await _authRepository.verifyOtp(email: event.email, otp: event.otp);
      if (valid) {
        emit(state.copyWith(status: AuthStatus.otpVerified));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Invalid OTP code. Please try again.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'OTP verification failed.',
      ));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.resetPassword(email: event.email, newPassword: event.newPassword);
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Password reset failed.',
      ));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
