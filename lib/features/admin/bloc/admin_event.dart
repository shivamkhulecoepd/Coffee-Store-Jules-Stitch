import 'package:equatable/equatable.dart';
import '../models/employee_model.dart';

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

class ToggleShiftEvent extends AdminEvent {
  final String employeeName;
  final EmployeeStatus currentStatus;
  const ToggleShiftEvent({required this.employeeName, required this.currentStatus});
  @override
  List<Object?> get props => [employeeName, currentStatus];
}

/// Internal event — emitted when inventory stream updates.
class InventoryAlertEvent extends AdminEvent {}
