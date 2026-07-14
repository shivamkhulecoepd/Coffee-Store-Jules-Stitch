import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import '../../../data/repositories/store_repository.dart';
import '../models/employee_model.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final StoreRepository _repository;
  StreamSubscription? _inventorySubscription;

  AdminBloc(this._repository) : super(const AdminState()) {
    on<LoadAdminDataEvent>(_onLoadData);
    on<ResolveRequestEvent>(_onResolveRequest);
    on<ToggleShiftEvent>(_onToggleShift);
    on<InventoryAlertEvent>(_onInventoryAlert);

    // Listen to inventory stream for real-time low-stock alerts
    _inventorySubscription = _repository.inventoryStream.listen((_) {
      add(InventoryAlertEvent());
    });
  }

  void _onLoadData(LoadAdminDataEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(status: AdminStatus.loading));

    final totalRevenue = _repository.orders.fold(0.0, (sum, o) => sum + ((o['total'] ?? 0.0) as double));
    final avgBasket = _repository.orders.isEmpty ? 0.0 : totalRevenue / _repository.orders.length;
    final lowStock = _repository.lowStockItems;
    final critical = _repository.criticalStockItems;

    emit(state.copyWith(
      status: AdminStatus.loaded,
      dailyRevenue: 1240.0 + totalRevenue,
      avgBasket: 18.5 + avgBasket,
      requests: [
        {'id': '8820', 'desc': 'Inquiry regarding subscription renewal benefits.', 'status': 'PENDING'},
        {'id': '8821', 'desc': 'Request for table #4 group booking reservation.', 'status': 'PENDING'},
      ],
      alerts: [
        ...lowStock.map((i) => {'item': i.name, 'status': 'LOW: ${i.quantity}', 'color': 'orange'}),
        ...critical.map((i) => {'item': i.name, 'status': 'CRITICAL: ${i.quantity}', 'color': 'error'}),
      ],
      inventoryItems: _repository.inventory,
      employees: _repository.employees,
    ));
  }

  void _onResolveRequest(ResolveRequestEvent event, Emitter<AdminState> emit) {
    _repository.resolveRequest(event.requestId);
    final updatedRequests = state.requests.map((r) {
      if (r['id'] == event.requestId) {
        return {...r, 'status': 'RESOLVED'};
      }
      return r;
    }).toList();
    emit(state.copyWith(requests: updatedRequests));
  }

  void _onToggleShift(ToggleShiftEvent event, Emitter<AdminState> emit) {
    final currentStatus = event.currentStatus;
    final newStatus = currentStatus == EmployeeStatus.onShift
        ? EmployeeStatus.offShift
        : EmployeeStatus.onShift;
    _repository.updateEmployeeStatus(event.employeeName, newStatus);
    emit(state.copyWith(employees: _repository.employees));
  }

  void _onInventoryAlert(InventoryAlertEvent event, Emitter<AdminState> emit) {
    // Re-derive alerts when inventory changes
    final lowStock = _repository.lowStockItems;
    final critical = _repository.criticalStockItems;
    emit(state.copyWith(
      inventoryItems: _repository.inventory,
      alerts: [
        ...lowStock.map((i) => {'item': i.name, 'status': 'LOW: ${i.quantity}', 'color': 'orange'}),
        ...critical.map((i) => {'item': i.name, 'status': 'CRITICAL: ${i.quantity}', 'color': 'error'}),
      ],
    ));
  }

  @override
  Future<void> close() {
    _inventorySubscription?.cancel();
    return super.close();
  }
}
