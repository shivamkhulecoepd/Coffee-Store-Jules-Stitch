import 'package:flutter_bloc/flutter_bloc.dart';
import 'ordering_event.dart';
import 'ordering_state.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../../../data/repositories/store_repository.dart';

class OrderingBloc extends Bloc<OrderingEvent, OrderingState> {
  final StoreRepository _repository;

  OrderingBloc(this._repository) : super(const OrderingState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<SearchProductsEvent>(_onSearch);
    on<FilterByCategoryEvent>(_onFilterCategory);
    on<SortProductsEvent>(_onSort);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
    on<ApplyPromoCodeEvent>(_onApplyPromo);
    on<RemovePromoCodeEvent>(_onRemovePromo);
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatus);
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(status: OrderingStatus.loading));
    final products = _repository.products;
    emit(state.copyWith(status: OrderingStatus.loaded, products: products));
  }

  void _onSearch(SearchProductsEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterCategory(FilterByCategoryEvent event, Emitter<OrderingState> emit) {
    if (event.category == null) {
      emit(state.copyWith(clearCategory: true));
    } else {
      emit(state.copyWith(selectedCategory: event.category));
    }
  }

  void _onSort(SortProductsEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(sortOption: event.sortOption));
  }

  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<OrderingState> emit) {
    _repository.toggleFavorite(event.productId);
    final updatedProducts = state.products.map((p) {
      if (p.id == event.productId) {
        return p.copyWith(isFavorite: !p.isFavorite);
      }
      return p;
    }).toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<OrderingState> emit) {
    final existingIndex = state.cart.indexWhere((item) => item.product.id == event.product.id);
    List<CartItem> updatedCart = List.from(state.cart);

    if (existingIndex != -1) {
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + event.quantity,
        customization: event.customization,
      );
    } else {
      updatedCart.add(CartItem(
        product: event.product,
        quantity: event.quantity,
        customization: event.customization,
      ));
    }
    emit(state.copyWith(cart: updatedCart));
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<OrderingState> emit) {
    final index = state.cart.indexWhere((item) => item.product.id == event.productId);
    if (index != -1) {
      List<CartItem> updatedCart = List.from(state.cart);
      final newQty = updatedCart[index].quantity + event.delta;
      if (newQty > 0) {
        updatedCart[index] = updatedCart[index].copyWith(quantity: newQty);
        emit(state.copyWith(cart: updatedCart));
      } else {
        updatedCart.removeAt(index);
        emit(state.copyWith(cart: updatedCart));
      }
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<OrderingState> emit) {
    final updatedCart = state.cart.where((item) => item.product.id != event.productId).toList();
    emit(state.copyWith(cart: updatedCart));
  }

  void _onClearCart(ClearCartEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(cart: [], clearPromo: true, clearPromoError: true));
  }

  void _onApplyPromo(ApplyPromoCodeEvent event, Emitter<OrderingState> emit) {
    final promo = PromoCode.validate(event.code);
    if (promo != null) {
      emit(state.copyWith(appliedPromo: promo, clearPromoError: true));
    } else {
      emit(state.copyWith(clearPromo: true, promoError: 'Invalid promo code.'));
    }
  }

  void _onRemovePromo(RemovePromoCodeEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(clearPromo: true, clearPromoError: true));
  }

  Future<void> _onPlaceOrder(PlaceOrderEvent event, Emitter<OrderingState> emit) async {
    if (state.cart.isEmpty) return;
    emit(state.copyWith(isPlacingOrder: true));

    final orderId = 'SESSION #${400 + _repository.orders.length}';
    final newOrder = Order(
      id: orderId,
      items: List.from(state.cart),
      status: OrderStatus.preparing,
      subtotal: state.subtotal,
      discount: state.discount,
      serviceFee: state.serviceFee,
      total: state.total,
      createdAt: DateTime.now(),
      promoCode: state.appliedPromo?.code,
    );

    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));

    // Add to repository — this broadcasts via _ordersController stream
    _repository.addOrder(newOrder.toMap());

    // Decrement inventory based on ordered items
    _repository.consumeInventoryForOrder(state.cart);

    emit(state.copyWith(
      isPlacingOrder: false,
      cart: [],
      clearPromo: true,
      orderHistory: _repository.orders,
    ));
  }

  void _onUpdateOrderStatus(UpdateOrderStatusEvent event, Emitter<OrderingState> emit) {
    // Update order status in repository stream
    _repository.updateOrderStatus(event.orderId, event.newStatus);
    emit(state.copyWith(orderHistory: List.from(_repository.orders)));
  }
}
