import 'package:flutter_bloc/flutter_bloc.dart';
import 'ordering_event.dart';
import 'ordering_state.dart';

class OrderingBloc extends Bloc<OrderingEvent, OrderingState> {
  OrderingBloc() : super(const OrderingState()) {
    on<AddToCartEvent>((event, emit) {
      final updatedCart = List<String>.from(state.cartItems)..add(event.product);
      emit(state.copyWith(cartItems: updatedCart));
    });

    on<PlaceOrderEvent>((event, emit) async {
      emit(state.copyWith(isPlacingOrder: true));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isPlacingOrder: false, cartItems: []));
    });
  }
}
