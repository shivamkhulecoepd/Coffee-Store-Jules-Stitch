import 'package:equatable/equatable.dart';
import '../models/table_session_model.dart';

enum BaristaStatus { initial, loading, loaded, error }

class BaristaState extends Equatable {
  final BaristaStatus status;
  final List<TableSession> tables;
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> activeOrders;
  final String? brewingOrderId;
  /// Set after a QR scan — null if scan failed or not attempted yet.
  final int? scannedTableId;
  final String? scanError;

  const BaristaState({
    this.status = BaristaStatus.initial,
    this.tables = const [],
    this.tasks = const [],
    this.activeOrders = const [],
    this.brewingOrderId,
    this.scannedTableId,
    this.scanError,
  });

  BaristaState copyWith({
    BaristaStatus? status,
    List<TableSession>? tables,
    List<Map<String, dynamic>>? tasks,
    List<Map<String, dynamic>>? activeOrders,
    String? brewingOrderId,
    bool clearBrewingOrderId = false,
    int? scannedTableId,
    bool clearScannedTableId = false,
    String? scanError,
    bool clearScanError = false,
  }) {
    return BaristaState(
      status: status ?? this.status,
      tables: tables ?? this.tables,
      tasks: tasks ?? this.tasks,
      activeOrders: activeOrders ?? this.activeOrders,
      brewingOrderId: clearBrewingOrderId ? null : (brewingOrderId ?? this.brewingOrderId),
      scannedTableId: clearScannedTableId ? null : (scannedTableId ?? this.scannedTableId),
      scanError: clearScanError ? null : (scanError ?? this.scanError),
    );
  }

  @override
  List<Object?> get props => [status, tables, tasks, activeOrders, brewingOrderId, scannedTableId, scanError];
}
