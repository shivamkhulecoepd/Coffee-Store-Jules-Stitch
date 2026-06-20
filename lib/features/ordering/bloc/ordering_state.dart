import 'package:equatable/equatable.dart';

class OrderingState extends Equatable {
  final List<String> cartItems;
  final bool isPlacingOrder;

  const OrderingState({
    this.cartItems = const [],
    this.isPlacingOrder = false,
  });

  OrderingState copyWith({
    List<String>? cartItems,
    bool? isPlacingOrder,
  }) {
    return OrderingState(
      cartItems: cartItems ?? this.cartItems,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
    );
  }

  @override
  List<Object> get props => [cartItems, isPlacingOrder];
}
