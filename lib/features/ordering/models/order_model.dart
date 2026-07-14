import 'package:equatable/equatable.dart';
import 'product_model.dart';

/// Possible statuses for a customer order.
enum OrderStatus {
  pending('Pending'),
  preparing('Preparing'),
  ready('Ready'),
  delivered('Delivered'),
  cancelled('Cancelled');

  final String displayName;
  const OrderStatus(this.displayName);
}

/// Represents a placed customer order.
class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final OrderStatus status;
  final double subtotal;
  final double discount;
  final double serviceFee;
  final double total;
  final DateTime createdAt;
  final String? promoCode;
  final String? notes;

  const Order({
    required this.id,
    required this.items,
    this.status = OrderStatus.pending,
    required this.subtotal,
    this.discount = 0.0,
    required this.serviceFee,
    required this.total,
    required this.createdAt,
    this.promoCode,
    this.notes,
  });

  /// Human-readable summary of items.
  String get itemsSummary => items.map((e) => '${e.quantity}x ${e.product.name}').join(', ');

  Order copyWith({
    String? id,
    List<CartItem>? items,
    OrderStatus? status,
    double? subtotal,
    double? discount,
    double? serviceFee,
    double? total,
    DateTime? createdAt,
    String? promoCode,
    String? notes,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      serviceFee: serviceFee ?? this.serviceFee,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      promoCode: promoCode ?? this.promoCode,
      notes: notes ?? this.notes,
    );
  }

  /// Converts to a Map for storage in StoreRepository (since it uses `Map<String, dynamic>`).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': itemsSummary,
      'status': status.displayName,
      'subtotal': subtotal,
      'discount': discount,
      'serviceFee': serviceFee,
      'total': total,
      'date': '${createdAt.month}/${createdAt.day}',
      'promoCode': promoCode,
    };
  }

  @override
  List<Object?> get props => [id, items, status, subtotal, discount, serviceFee, total, createdAt, promoCode, notes];
}

/// Supported promo codes and their discounts.
class PromoCode {
  final String code;
  final double discountPercent; // e.g. 0.10 = 10%
  final String description;

  const PromoCode({
    required this.code,
    required this.discountPercent,
    required this.description,
  });

  /// Returns the discount amount for a given subtotal.
  double calculateDiscount(double subtotal) => subtotal * discountPercent;

  static const Map<String, PromoCode> validCodes = {
    'ARTISAN10': PromoCode(
      code: 'ARTISAN10',
      discountPercent: 0.10,
      description: '10% off your order',
    ),
    'WELCOME20': PromoCode(
      code: 'WELCOME20',
      discountPercent: 0.20,
      description: '20% off — welcome offer',
    ),
    'BEANBREW': PromoCode(
      code: 'BEANBREW',
      discountPercent: 0.15,
      description: '15% off beans and brews',
    ),
  };

  static PromoCode? validate(String code) => validCodes[code.toUpperCase()];
}
