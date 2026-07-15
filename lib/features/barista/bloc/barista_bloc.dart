import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'barista_event.dart';
import 'barista_state.dart';
import '../models/table_session_model.dart';
import '../../../data/repositories/store_repository.dart';

class BaristaBloc extends Bloc<BaristaEvent, BaristaState> {
  final StoreRepository _repository;
  StreamSubscription<List<Map<String, dynamic>>>? _ordersSubscription;
  StreamSubscription<List<dynamic>>? _tableSubscription;

  BaristaBloc(this._repository) : super(const BaristaState()) {
    on<LoadBaristaDataEvent>(_onLoadData);
    on<UpdateTableStatusEvent>(_onUpdateTable);
    on<CloseTableSessionEvent>(_onCloseSession);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<StartBrewingEvent>(_onStartBrewing);
    on<OrderStatusUpdatedEvent>(_onOrderStatusUpdated);
    on<StartTableSessionEvent>(_onStartTableSession);
    on<SyncQRCodeEvent>(_onSyncQRCode);
    on<AddItemToTableSessionEvent>(_onAddItemToTable);
    on<MarkBrewReadyEvent>(_onMarkBrewReady);
    on<_TableStreamUpdatedEvent>(_onTableStreamUpdated);

    // Subscribe to orders stream — new customer orders appear here automatically
    _ordersSubscription = _repository.ordersStream.listen((orders) {
      add(OrderStatusUpdatedEvent(orders));
    });

    // Subscribe to table stream — live table status changes
    _tableSubscription = _repository.tableStream.listen((tables) {
      add(_TableStreamUpdatedEvent(tables));
    });
  }

  void _onLoadData(LoadBaristaDataEvent event, Emitter<BaristaState> emit) {
    emit(state.copyWith(status: BaristaStatus.loading));
    emit(state.copyWith(
      status: BaristaStatus.loaded,
      tables: _repository.tables,
      tasks: _repository.tasks,
      activeOrders: _repository.activeOrders,
    ));
  }

  void _onUpdateTable(UpdateTableStatusEvent event, Emitter<BaristaState> emit) {
    _repository.setTableStatus(event.tableId, event.status);
    emit(state.copyWith(tables: _repository.tables));
  }

  void _onCloseSession(CloseTableSessionEvent event, Emitter<BaristaState> emit) {
    final session = _repository.findTableById(event.tableId);
    if (session == null) return;
    final closed = session.copyWith(
      status: TableStatus.vacant,
      items: const [],
      startTime: null,
    );
    _repository.updateTableSession(closed);
    emit(state.copyWith(tables: _repository.tables));
  }

  void _onCompleteTask(CompleteTaskEvent event, Emitter<BaristaState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t['title'] == event.taskTitle) {
        return {...t, 'status': 'COMPLETED', 'color': 'success'};
      }
      return t;
    }).toList();
    // Persist to repository so other parts of the app see the change
    _repository.updateTask(event.taskTitle, 'COMPLETED', 'success');
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onStartBrewing(StartBrewingEvent event, Emitter<BaristaState> emit) {
    _repository.updateOrderStatus(event.orderId, 'Preparing');
    emit(state.copyWith(
      activeOrders: _repository.activeOrders,
      brewingOrderId: event.orderId,
    ));
  }

  void _onOrderStatusUpdated(OrderStatusUpdatedEvent event, Emitter<BaristaState> emit) {
    emit(state.copyWith(activeOrders: _repository.activeOrders));
  }

  void _onStartTableSession(StartTableSessionEvent event, Emitter<BaristaState> emit) {
    final existing = _repository.findTableById(event.tableId);
    if (existing == null) return;
    final session = existing.copyWith(
      status: TableStatus.occupied,
      startTime: DateTime.now(),
    );
    _repository.updateTableSession(session);
    emit(state.copyWith(tables: _repository.tables));
  }

  void _onSyncQRCode(SyncQRCodeEvent event, Emitter<BaristaState> emit) {
    final table = _repository.findTableById(event.tableId);
    if (table == null) {
      emit(state.copyWith(scannedTableId: null, scanError: 'Table not found'));
      return;
    }
    emit(state.copyWith(scannedTableId: event.tableId, scanError: null));
  }

  void _onAddItemToTable(AddItemToTableSessionEvent event, Emitter<BaristaState> emit) {
    _repository.addItemToTableSession(event.tableId, event.item);
    emit(state.copyWith(tables: _repository.tables));
  }

  void _onMarkBrewReady(MarkBrewReadyEvent event, Emitter<BaristaState> emit) {
    _repository.updateOrderStatus(event.orderId, 'Ready');
    _repository.incrementOrdersCompleted();
    emit(state.copyWith(
      activeOrders: _repository.activeOrders,
      brewingOrderId: state.brewingOrderId == event.orderId ? null : state.brewingOrderId,
    ));
  }

  void _onTableStreamUpdated(_TableStreamUpdatedEvent event, Emitter<BaristaState> emit) {
    // The repository emits List<TableSession> — cast from dynamic
    final tables = event.tables.cast<TableSession>();
    emit(state.copyWith(tables: tables));
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    _tableSubscription?.cancel();
    return super.close();
  }
}

// Internal event for table stream updates
class _TableStreamUpdatedEvent extends BaristaEvent {
  final List<dynamic> tables;
  const _TableStreamUpdatedEvent(this.tables);
  @override
  List<Object?> get props => [tables];
}
