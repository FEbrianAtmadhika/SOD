part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartAddLoading extends CartState {}

class CartFailed extends CartState {
  final String e;

  const CartFailed(this.e);

  @override
  List<Object> get props => [e];
}

class CartAddFailed extends CartState {
  final String e;

  const CartAddFailed(this.e);

  @override
  List<Object> get props => [e];
}

class CartDelFailed extends CartState {
  final String e;

  const CartDelFailed(this.e);

  @override
  List<Object> get props => [e];
}

class CartSuccess extends CartState {
  final List<CartModel> cart;
  const CartSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartDelSuccess extends CartState {}

class AddCartSuccess extends CartState {
  final String e;
  const AddCartSuccess(this.e);

  @override
  List<Object> get props => [e];
}
