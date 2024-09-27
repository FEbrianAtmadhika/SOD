part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartGetAll extends CartEvent {}

class AddCartItem extends CartEvent {
  final AddCartModel data;

  const AddCartItem(this.data);
  @override
  List<Object> get props => [data];
}

class DelCartIem extends CartEvent {
  final List<CartModel> data;
  final List<int> idcart;
  const DelCartIem(this.data, this.idcart);

  @override
  List<Object> get props => [data, idcart];
}
