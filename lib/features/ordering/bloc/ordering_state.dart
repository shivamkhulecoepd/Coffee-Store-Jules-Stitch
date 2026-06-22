import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

enum OrderingStatus { initial, loading, loaded, success, error }

class OrderingState extends Equatable {
  final OrderingStatus status;
  final List<Product> products;
  final List<CartItem> cart;
  final List<Map<String, dynamic>> orderHistory;
  final bool isPlacingOrder;

  const OrderingState({
    this.status = OrderingStatus.initial,
    this.products = const [],
    this.cart = const [],
    this.orderHistory = const [],
    this.isPlacingOrder = false,
  });

  double get subtotal => cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  double get serviceFee => cart.isEmpty ? 0 : 1.50;
  double get total => subtotal + serviceFee;

  OrderingState copyWith({
    OrderingStatus? status,
    List<Product>? products,
    List<CartItem>? cart,
    List<Map<String, dynamic>>? orderHistory,
    bool? isPlacingOrder,
  }) {
    return OrderingState(
      status: status ?? this.status,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      orderHistory: orderHistory ?? this.orderHistory,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
    );
  }

  @override
  List<Object> get props => [status, products, cart, orderHistory, isPlacingOrder];
}
