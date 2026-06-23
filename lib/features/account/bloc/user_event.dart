import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserEvent extends UserEvent {}

class UpdateSubscriptionEvent extends UserEvent {
  final String plan;
  const UpdateSubscriptionEvent(this.plan);
  @override
  List<Object?> get props => [plan];
}

class RedeemPointsEvent extends UserEvent {
  final int points;
  const RedeemPointsEvent(this.points);
  @override
  List<Object?> get props => [points];
}
