import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class LoadAdminDataEvent extends AdminEvent {}

class ResolveRequestEvent extends AdminEvent {
  final String requestId;
  const ResolveRequestEvent(this.requestId);
  @override
  List<Object?> get props => [requestId];
}
