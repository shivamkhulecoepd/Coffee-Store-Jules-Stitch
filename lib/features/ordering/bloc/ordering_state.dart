import 'package:equatable/equatable.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

enum OrderingStatus { initial, loading, loaded, success, error }

class OrderingState extends Equatable {
  final OrderingStatus status;
  final List<Product> products;
  final List<CartItem> cart;
  final List<Map<String, dynamic>> orderHistory;
  final bool isPlacingOrder;

  // Search / filter / sort
  final String searchQuery;
  final String? selectedCategory;
  final String sortOption;

  // Promo
  final PromoCode? appliedPromo;
  final String? promoError;

  const OrderingState({
    this.status = OrderingStatus.initial,
    this.products = const [],
    this.cart = const [],
    this.orderHistory = const [],
    this.isPlacingOrder = false,
    this.searchQuery = '',
    this.selectedCategory,
    this.sortOption = 'Name',
    this.appliedPromo,
    this.promoError,
  });

  /// Subtotal without discount.
  double get subtotal => cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  /// Discount amount from applied promo code.
  double get discount => appliedPromo?.calculateDiscount(subtotal) ?? 0.0;

  /// Fixed service fee.
  double get serviceFee => cart.isEmpty ? 0.0 : 1.50;

  /// Final total after discount and fees.
  double get total => subtotal - discount + serviceFee;

  /// Returns products filtered by current search/category/sort state.
  List<Product> get filteredProducts {
    var result = products.where((p) {
      final matchesQuery = searchQuery.isEmpty ||
          p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == null || p.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    switch (sortOption) {
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default: // 'Name'
        result.sort((a, b) => a.name.compareTo(b.name));
    }

    return result;
  }

  /// Available category options derived from product list.
  Set<String> get availableCategories => products.map((p) => p.category).toSet();

  OrderingState copyWith({
    OrderingStatus? status,
    List<Product>? products,
    List<CartItem>? cart,
    List<Map<String, dynamic>>? orderHistory,
    bool? isPlacingOrder,
    String? searchQuery,
    String? selectedCategory,
    bool clearCategory = false,
    String? sortOption,
    PromoCode? appliedPromo,
    bool clearPromo = false,
    String? promoError,
    bool clearPromoError = false,
  }) {
    return OrderingState(
      status: status ?? this.status,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      orderHistory: orderHistory ?? this.orderHistory,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      sortOption: sortOption ?? this.sortOption,
      appliedPromo: clearPromo ? null : (appliedPromo ?? this.appliedPromo),
      promoError: clearPromoError ? null : (promoError ?? this.promoError),
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        cart,
        orderHistory,
        isPlacingOrder,
        searchQuery,
        selectedCategory,
        sortOption,
        appliedPromo,
        promoError,
      ];
}
