import 'package:equatable/equatable.dart';

abstract class OrderingEvent extends Equatable {
  const OrderingEvent();
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends OrderingEvent {
  final String product;
  const AddToCartEvent(this.product);
  @override
  List<Object> get props => [product];
}

class PlaceOrderEvent extends OrderingEvent {}
