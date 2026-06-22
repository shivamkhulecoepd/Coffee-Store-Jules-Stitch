import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final String heroTag;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.heroTag,
  });

  @override
  List<Object> get props => [id, name, description, price, rating, category, heroTag];
}

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  final String? customization;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.customization,
  });

  CartItem copyWith({Product? product, int? quantity, String? customization}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      customization: customization ?? this.customization,
    );
  }

  @override
  List<Object?> get props => [product, quantity, customization];
}
