import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'barista_event.dart';
import 'barista_state.dart';
import '../../../data/repositories/store_repository.dart';
import '../models/table_session_model.dart';

class BaristaBloc extends Bloc<BaristaEvent, BaristaState> {
  final StoreRepository _repository;
  StreamSubscription<List<Map<String, dynamic>>>? _ordersSubscription;

  BaristaBloc(this._repository) : super(const BaristaState()) {
    on<LoadBaristaDataEvent>(_onLoadData);
    on<UpdateTableStatusEvent>(_onUpdateTable);
    on<CloseTableSessionEvent>(_onCloseSession);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<StartBrewingEvent>(_onStartBrewing);
    on<OrderStatusUpdatedEvent>(_onOrderStatusUpdated);
    on<StartTableSessionEvent>(_onStartTableSession);

    // Subscribe to orders stream — this is how new customer orders appear
    _ordersSubscription = _repository.ordersStream.listen((orders) {
      add(OrderStatusUpdatedEvent(orders));
    });
  }

  void _onLoadData(LoadBaristaDataEvent event, Emitter<BaristaState> emit) {
    emit(state.copyWith(status: BaristaStatus.loading));
    emit(state.copyWith(
      status: BaristaStatus.loaded,
      tables: _repository.tables,
      tasks: _repository.tasks,
      activeOrders: _repository.orders,
    ));
  }

  void _onUpdateTable(UpdateTableStatusEvent event, Emitter<BaristaState> emit) {
    final updatedTables = state.tables.map((t) {
      if (t.tableId == event.tableId) {
        return t.copyWith(status: event.status);
      }
      return t;
    }).toList();
    emit(state.copyWith(tables: updatedTables));
    final updatedTable = updatedTables.firstWhere((t) => t.tableId == event.tableId);
    _repository.updateTableSession(updatedTable);
  }

  void _onCloseSession(CloseTableSessionEvent event, Emitter<BaristaState> emit) {
    final updatedTables = state.tables.map((t) {
      if (t.tableId == event.tableId) {
        return TableSession(tableId: event.tableId);
      }
      return t;
    }).toList();
    emit(state.copyWith(tables: updatedTables));
    final updatedTable = updatedTables.firstWhere((t) => t.tableId == event.tableId);
    _repository.updateTableSession(updatedTable);
  }

  void _onCompleteTask(CompleteTaskEvent event, Emitter<BaristaState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t['title'] == event.taskTitle) {
        return {...t, 'status': 'COMPLETED', 'color': 'success'};
      }
      return t;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onStartBrewing(StartBrewingEvent event, Emitter<BaristaState> emit) {
    // Mark the order as 'Preparing' in the repository
    _repository.updateOrderStatus(event.orderId, 'Preparing');
    emit(state.copyWith(
      activeOrders: _repository.orders,
      brewingOrderId: event.orderId,
    ));
  }

  void _onOrderStatusUpdated(OrderStatusUpdatedEvent event, Emitter<BaristaState> emit) {
    emit(state.copyWith(activeOrders: event.orders));
  }

  void _onStartTableSession(StartTableSessionEvent event, Emitter<BaristaState> emit) {
    final session = TableSession(
      tableId: event.tableId,
      status: TableStatus.occupied,
      startTime: DateTime.now(),
    );
    _repository.updateTableSession(session);
    emit(state.copyWith(tables: _repository.tables));
  }

  /// Mark an order as Ready — this triggers the customer tracking stream.
  void markOrderReady(String orderId) {
    _repository.updateOrderStatus(orderId, 'Ready');
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
