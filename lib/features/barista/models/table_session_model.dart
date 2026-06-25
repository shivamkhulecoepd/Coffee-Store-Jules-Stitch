import 'package:equatable/equatable.dart';
import '../../ordering/models/product_model.dart';

enum TableStatus { vacant, occupied, readyToBill, preparing, completed }

class TableSession extends Equatable {
  final int tableId;
  final TableStatus status;
  final List<CartItem> items;
  final DateTime? startTime;

  const TableSession({
    required this.tableId,
    this.status = TableStatus.vacant,
    this.items = const [],
    this.startTime,
  });

  double get total => items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  TableSession copyWith({
    int? tableId,
    TableStatus? status,
    List<CartItem>? items,
    DateTime? startTime,
  }) {
    return TableSession(
      tableId: tableId ?? this.tableId,
      status: status ?? this.status,
      items: items ?? this.items,
      startTime: startTime ?? this.startTime,
    );
  }

  @override
  List<Object?> get props => [tableId, status, items, startTime];
}
