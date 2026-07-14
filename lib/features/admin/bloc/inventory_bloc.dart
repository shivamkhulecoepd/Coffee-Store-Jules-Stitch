import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/store_repository.dart';
import '../models/inventory_item_model.dart';

// ─── Events ────────────────────────────────────────────────────────────────

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
  @override
  List<Object?> get props => [];
}

class LoadInventoryEvent extends InventoryEvent {}

class ReorderItemEvent extends InventoryEvent {
  final String itemId;
  const ReorderItemEvent(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

class InventoryUpdatedEvent extends InventoryEvent {
  final List<InventoryItem> items;
  const InventoryUpdatedEvent(this.items);
  @override
  List<Object?> get props => [items];
}

// ─── State ─────────────────────────────────────────────────────────────────

enum InventoryStatus { initial, loading, loaded, error }

class InventoryState extends Equatable {
  final InventoryStatus status;
  final List<InventoryItem> items;
  final List<InventoryItem> lowStockItems;
  final List<InventoryItem> criticalItems;
  final String? errorMessage;

  const InventoryState({
    this.status = InventoryStatus.initial,
    this.items = const [],
    this.lowStockItems = const [],
    this.criticalItems = const [],
    this.errorMessage,
  });

  InventoryState copyWith({
    InventoryStatus? status,
    List<InventoryItem>? items,
    List<InventoryItem>? lowStockItems,
    List<InventoryItem>? criticalItems,
    String? errorMessage,
  }) {
    return InventoryState(
      status: status ?? this.status,
      items: items ?? this.items,
      lowStockItems: lowStockItems ?? this.lowStockItems,
      criticalItems: criticalItems ?? this.criticalItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, lowStockItems, criticalItems, errorMessage];
}

// ─── Bloc ──────────────────────────────────────────────────────────────────

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final StoreRepository _repository;
  StreamSubscription<List<InventoryItem>>? _inventorySubscription;

  InventoryBloc(this._repository) : super(const InventoryState()) {
    on<LoadInventoryEvent>(_onLoad);
    on<ReorderItemEvent>(_onReorder);
    on<InventoryUpdatedEvent>(_onInventoryUpdated);

    // Subscribe to inventory stream — auto-updates when stock changes
    _inventorySubscription = _repository.inventoryStream.listen((items) {
      add(InventoryUpdatedEvent(items));
    });
  }

  void _onLoad(LoadInventoryEvent event, Emitter<InventoryState> emit) {
    emit(state.copyWith(status: InventoryStatus.loading));
    emit(state.copyWith(
      status: InventoryStatus.loaded,
      items: _repository.inventory,
      lowStockItems: _repository.lowStockItems,
      criticalItems: _repository.criticalStockItems,
    ));
  }

  void _onReorder(ReorderItemEvent event, Emitter<InventoryState> emit) {
    _repository.reorderItem(event.itemId);
    emit(state.copyWith(
      items: _repository.inventory,
      lowStockItems: _repository.lowStockItems,
      criticalItems: _repository.criticalStockItems,
    ));
  }

  void _onInventoryUpdated(InventoryUpdatedEvent event, Emitter<InventoryState> emit) {
    emit(state.copyWith(
      status: InventoryStatus.loaded,
      items: event.items,
      lowStockItems: _repository.lowStockItems,
      criticalItems: _repository.criticalStockItems,
    ));
  }

  @override
  Future<void> close() {
    _inventorySubscription?.cancel();
    return super.close();
  }
}
