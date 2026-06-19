import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<SelectRoleEvent>((event, emit) {
      emit(state.copyWith(role: event.role));
    });

    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      await Future.delayed(const Duration(seconds: 1)); // Mock API
      emit(state.copyWith(status: AuthStatus.authenticated));
    });
  }
}
