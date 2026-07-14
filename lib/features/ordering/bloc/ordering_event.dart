import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

abstract class OrderingEvent extends Equatable {
  const OrderingEvent();
  @override
  List<Object?> get props => [];
}

// ─── Product / Catalog ──────────────────────────────────────────────────────

class LoadProductsEvent extends OrderingEvent {}

class SearchProductsEvent extends OrderingEvent {
  final String query;
  const SearchProductsEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class FilterByCategoryEvent extends OrderingEvent {
  final String? category;
  const FilterByCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}

class SortProductsEvent extends OrderingEvent {
  final String sortOption; // 'Name', 'Price: Low to High', 'Price: High to Low', 'Rating'
  const SortProductsEvent(this.sortOption);
  @override
  List<Object?> get props => [sortOption];
}

class ToggleFavoriteEvent extends OrderingEvent {
  final String productId;
  const ToggleFavoriteEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}

// ─── Cart ───────────────────────────────────────────────────────────────────

class AddToCartEvent extends OrderingEvent {
  final Product product;
  final int quantity;
  final String? customization;
  const AddToCartEvent(this.product, {this.quantity = 1, this.customization});
  @override
  List<Object?> get props => [product, quantity, customization];
}

class UpdateQuantityEvent extends OrderingEvent {
  final String productId;
  final int delta;
  const UpdateQuantityEvent(this.productId, this.delta);
  @override
  List<Object?> get props => [productId, delta];
}

class RemoveFromCartEvent extends OrderingEvent {
  final String productId;
  const RemoveFromCartEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}

class ClearCartEvent extends OrderingEvent {}

// ─── Promo ──────────────────────────────────────────────────────────────────

class ApplyPromoCodeEvent extends OrderingEvent {
  final String code;
  const ApplyPromoCodeEvent(this.code);
  @override
  List<Object?> get props => [code];
}

class RemovePromoCodeEvent extends OrderingEvent {}

// ─── Checkout / Orders ───────────────────────────────────────────────────────

class PlaceOrderEvent extends OrderingEvent {}

class UpdateOrderStatusEvent extends OrderingEvent {
  final String orderId;
  final String newStatus;
  const UpdateOrderStatusEvent(this.orderId, this.newStatus);
  @override
  List<Object?> get props => [orderId, newStatus];
}
