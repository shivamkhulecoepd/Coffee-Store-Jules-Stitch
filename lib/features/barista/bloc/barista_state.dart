import 'package:equatable/equatable.dart';
import '../models/table_session_model.dart';

enum BaristaStatus { initial, loading, loaded, error }

class BaristaState extends Equatable {
  final BaristaStatus status;
  final List<TableSession> tables;
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> activeOrders;
  final String? brewingOrderId;

  const BaristaState({
    this.status = BaristaStatus.initial,
    this.tables = const [],
    this.tasks = const [],
    this.activeOrders = const [],
    this.brewingOrderId,
  });

  BaristaState copyWith({
    BaristaStatus? status,
    List<TableSession>? tables,
    List<Map<String, dynamic>>? tasks,
    List<Map<String, dynamic>>? activeOrders,
    String? brewingOrderId,
    bool clearBrewingOrderId = false,
  }) {
    return BaristaState(
      status: status ?? this.status,
      tables: tables ?? this.tables,
      tasks: tasks ?? this.tasks,
      activeOrders: activeOrders ?? this.activeOrders,
      brewingOrderId: clearBrewingOrderId ? null : (brewingOrderId ?? this.brewingOrderId),
    );
  }

  @override
  List<Object?> get props => [status, tables, tasks, activeOrders, brewingOrderId];
}
