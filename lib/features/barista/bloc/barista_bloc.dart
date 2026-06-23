import 'package:flutter_bloc/flutter_bloc.dart';
import 'barista_event.dart';
import 'barista_state.dart';
import '../../../data/repositories/store_repository.dart';

class BaristaBloc extends Bloc<BaristaEvent, BaristaState> {
  final StoreRepository _repository;

  BaristaBloc(this._repository) : super(const BaristaState()) {
    on<LoadBaristaDataEvent>(_onLoadData);
    on<UpdateTableStatusEvent>(_onUpdateTable);
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
      if (t['id'] == event.tableId) {
        return {...t, 'status': event.status};
      }
      return t;
    }).toList();
    emit(state.copyWith(tables: updatedTables));
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
