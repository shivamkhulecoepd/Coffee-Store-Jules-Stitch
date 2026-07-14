import 'package:equatable/equatable.dart';
import '../models/inventory_item_model.dart';
import '../models/employee_model.dart';

enum AdminStatus { initial, loading, loaded, error }

class AdminState extends Equatable {
  final AdminStatus status;
  final double dailyRevenue;
  final double avgBasket;
  final List<Map<String, dynamic>> requests;
  final List<Map<String, dynamic>> alerts;
  final List<InventoryItem> inventoryItems;
  final List<Employee> employees;

  const AdminState({
    this.status = AdminStatus.initial,
    this.dailyRevenue = 0.0,
    this.avgBasket = 0.0,
    this.requests = const [],
    this.alerts = const [],
    this.inventoryItems = const [],
    this.employees = const [],
  });

  AdminState copyWith({
    AdminStatus? status,
    double? dailyRevenue,
    double? avgBasket,
    List<Map<String, dynamic>>? requests,
    List<Map<String, dynamic>>? alerts,
    List<InventoryItem>? inventoryItems,
    List<Employee>? employees,
  }) {
    return AdminState(
      status: status ?? this.status,
      dailyRevenue: dailyRevenue ?? this.dailyRevenue,
      avgBasket: avgBasket ?? this.avgBasket,
      requests: requests ?? this.requests,
      alerts: alerts ?? this.alerts,
      inventoryItems: inventoryItems ?? this.inventoryItems,
      employees: employees ?? this.employees,
    );
  }

  @override
  List<Object> get props => [status, dailyRevenue, avgBasket, requests, alerts, inventoryItems, employees];
}
