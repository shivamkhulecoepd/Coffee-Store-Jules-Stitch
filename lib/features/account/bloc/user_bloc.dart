import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<LoadUserEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
      // Simulate load
      emit(state.copyWith(isLoading: false));
    });

    on<UpdateSubscriptionEvent>((event, emit) {
      emit(state.copyWith(subscriptionPlan: event.plan));
    });

    on<RedeemPointsEvent>((event, emit) {
      if (state.points >= event.points) {
        emit(state.copyWith(points: state.points - event.points));
      }
    });
  }
}
