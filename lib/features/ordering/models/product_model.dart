import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final String heroTag;
  final String imageUrl;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.heroTag,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? rating,
    String? category,
    String? heroTag,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      heroTag: heroTag ?? this.heroTag,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [id, name, description, price, rating, category, heroTag, imageUrl, isFavorite];
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
