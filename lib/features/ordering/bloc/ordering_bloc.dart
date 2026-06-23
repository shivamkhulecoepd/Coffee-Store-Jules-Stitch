import 'package:flutter_bloc/flutter_bloc.dart';
import 'ordering_event.dart';
import 'ordering_state.dart';
import '../models/product_model.dart';
import '../../../data/repositories/store_repository.dart';

class OrderingBloc extends Bloc<OrderingEvent, OrderingState> {
  final StoreRepository _repository;

  OrderingBloc(this._repository) : super(const OrderingState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<OrderingState> emit) {
    emit(state.copyWith(status: OrderingStatus.loading));
    final products = _repository.products;
    emit(state.copyWith(status: OrderingStatus.loaded, products: products));
  }

  void _onAddToCart(AddToCartEvent event, Emitter<OrderingState> emit) {
    final existingIndex = state.cart.indexWhere((item) => item.product.id == event.product.id);
    List<CartItem> updatedCart = List.from(state.cart);

    if (existingIndex != -1) {
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + event.quantity,
      );
    } else {
      updatedCart.add(CartItem(product: event.product, quantity: event.quantity, customization: event.customization));
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

  Future<void> _onPlaceOrder(PlaceOrderEvent event, Emitter<OrderingState> emit) async {
    if (state.cart.isEmpty) return;
    emit(state.copyWith(isPlacingOrder: true));

    final newOrder = {
      'id': 'SESSION #${400 + _repository.orders.length}',
      'items': state.cart.map((e) => '${e.quantity}x ${e.product.name}').join(', '),
      'date': 'Oct 24',
      'status': 'Delivered',
      'total': state.total,
    };

    await Future.delayed(const Duration(seconds: 2));

    _repository.addOrder(newOrder);

    emit(state.copyWith(
      isPlacingOrder: false,
      cart: [],
      orderHistory: _repository.orders,
    ));
  }

  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<OrderingState> emit) {
    final updatedProducts = state.products.map((p) {
      if (p.id == event.productId) {
        return p.copyWith(isFavorite: !p.isFavorite);
      }
      return p;
    }).toList();
    emit(state.copyWith(products: updatedProducts));
  }
}
