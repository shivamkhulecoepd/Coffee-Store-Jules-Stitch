import 'package:equatable/equatable.dart';

class InventoryItem extends Equatable {
  final String id;
  final String name;
  final String quantity;
  final double progress; // 0.0 to 1.0 representing stock level

  const InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.progress,
  });

  InventoryItem copyWith({
    String? id,
    String? name,
    String? quantity,
    double? progress,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object> get props => [id, name, quantity, progress];
}
