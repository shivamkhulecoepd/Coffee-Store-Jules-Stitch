import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

abstract class OrderingEvent extends Equatable {
  const OrderingEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends OrderingEvent {}

class AddToCartEvent extends OrderingEvent {
  final Product product;
  final int quantity;
  final String? customization;
  const AddToCartEvent(this.product, {this.quantity = 1, this.customization});
  @override
  List<Object?> get props => [product, quantity, customization];
}

class RemoveFromCartEvent extends OrderingEvent {
  final String productId;
  const RemoveFromCartEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateQuantityEvent extends OrderingEvent {
  final String productId;
  final int delta;
  const UpdateQuantityEvent(this.productId, this.delta);
  @override
  List<Object?> get props => [productId, delta];
}

class PlaceOrderEvent extends OrderingEvent {}

class ToggleFavoriteEvent extends OrderingEvent {
  final String productId;
  const ToggleFavoriteEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}
