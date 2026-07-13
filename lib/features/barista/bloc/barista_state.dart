import 'package:equatable/equatable.dart';
import '../models/table_session_model.dart';

enum BaristaStatus { initial, loading, loaded, error }

class BaristaState extends Equatable {
  final BaristaStatus status;
  final List<TableSession> tables;
  final List<Map<String, dynamic>> tasks;

  const BaristaState({
    this.status = BaristaStatus.initial,
    this.tables = const [],
    this.tasks = const [],
  });

  BaristaState copyWith({
    BaristaStatus? status,
    List<TableSession>? tables,
    List<Map<String, dynamic>>? tasks,
  }) {
    return BaristaState(
      status: status ?? this.status,
      tables: tables ?? this.tables,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [status, tables, tasks];
}
