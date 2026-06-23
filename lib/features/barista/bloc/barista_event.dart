import 'package:equatable/equatable.dart';

abstract class BaristaEvent extends Equatable {
  const BaristaEvent();
  @override
  List<Object?> get props => [];
}

class LoadBaristaDataEvent extends BaristaEvent {}

class UpdateTableStatusEvent extends BaristaEvent {
  final int tableId;
  final String status;
  const UpdateTableStatusEvent(this.tableId, this.status);
  @override
  List<Object?> get props => [tableId, status];
}

class CompleteTaskEvent extends BaristaEvent {
  final String taskTitle;
  const CompleteTaskEvent(this.taskTitle);
  @override
  List<Object?> get props => [taskTitle];
}

class StartBrewingEvent extends BaristaEvent {
  final String orderId;
  const StartBrewingEvent(this.orderId);
  @override
  List<Object?> get props => [orderId];
}
