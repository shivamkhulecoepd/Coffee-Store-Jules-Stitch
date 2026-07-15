import 'package:equatable/equatable.dart';
import '../models/table_session_model.dart';
import '../../ordering/models/product_model.dart';

abstract class BaristaEvent extends Equatable {
  const BaristaEvent();
  @override
  List<Object?> get props => [];
}

class LoadBaristaDataEvent extends BaristaEvent {}

class UpdateTableStatusEvent extends BaristaEvent {
  final int tableId;
  final TableStatus status;
  const UpdateTableStatusEvent(this.tableId, this.status);
  @override
  List<Object?> get props => [tableId, status];
}

class CloseTableSessionEvent extends BaristaEvent {
  final int tableId;
  const CloseTableSessionEvent(this.tableId);
  @override
  List<Object?> get props => [tableId];
}

class StartTableSessionEvent extends BaristaEvent {
  final int tableId;
  const StartTableSessionEvent(this.tableId);
  @override
  List<Object?> get props => [tableId];
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

/// Mark a brew as Ready — updates order status in repository and increments performance.
class MarkBrewReadyEvent extends BaristaEvent {
  final String orderId;
  const MarkBrewReadyEvent(this.orderId);
  @override
  List<Object?> get props => [orderId];
}

/// Simulates a QR scan — resolves tableId and stores result in state.
class SyncQRCodeEvent extends BaristaEvent {
  final int tableId;
  const SyncQRCodeEvent(this.tableId);
  @override
  List<Object?> get props => [tableId];
}

/// Adds a cart item to an existing table session.
class AddItemToTableSessionEvent extends BaristaEvent {
  final int tableId;
  final CartItem item;
  const AddItemToTableSessionEvent(this.tableId, this.item);
  @override
  List<Object?> get props => [tableId, item];
}

/// Internal event — emitted when orders stream updates.
class OrderStatusUpdatedEvent extends BaristaEvent {
  final List<Map<String, dynamic>> orders;
  const OrderStatusUpdatedEvent(this.orders);
  @override
  List<Object?> get props => [orders];
}
