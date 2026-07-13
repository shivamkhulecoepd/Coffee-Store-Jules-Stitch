import 'package:flutter_bloc/flutter_bloc.dart';
import 'barista_event.dart';
import 'barista_state.dart';
import '../../../data/repositories/store_repository.dart';
import '../models/table_session_model.dart';

class BaristaBloc extends Bloc<BaristaEvent, BaristaState> {
  final StoreRepository _repository;

  BaristaBloc(this._repository) : super(const BaristaState()) {
    on<LoadBaristaDataEvent>(_onLoadData);
    on<UpdateTableStatusEvent>(_onUpdateTable);
    on<CloseTableSessionEvent>(_onCloseSession);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<StartBrewingEvent>((event, emit) {
      // Mock starting brew
    });
  }

  void _onLoadData(LoadBaristaDataEvent event, Emitter<BaristaState> emit) {
    emit(state.copyWith(status: BaristaStatus.loading));
    emit(state.copyWith(
      status: BaristaStatus.loaded,
      tables: _repository.tables,
      tasks: _repository.tasks,
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
}
