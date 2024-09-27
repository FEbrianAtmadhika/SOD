import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sod_new/models/addcartmodel.dart';
import 'package:sod_new/models/cartmodel.dart';
import 'package:sod_new/models/categorymodel.dart';
import 'package:sod_new/models/kacaumodel.dart';
import 'package:sod_new/services/cartservice.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is CartGetAll) {
        try {
          print('Cart Get All');

          emit(CartLoading());

          List<CartModel> res = await CartService().getAllCart();

          emit(CartSuccess(res));
        } catch (e) {
          emit(CartFailed(e.toString()));
        }
      }
      if (event is AddCartItem) {
        try {
          print('Add Cart');
          emit(CartAddLoading());

          String res = await CartService().addCart(event.data);

          emit(AddCartSuccess(res));
        } catch (e) {
          emit(CartAddFailed(e.toString()));
        }
      }
      if (event is DelCartIem) {
        try {
          emit(CartLoading());
          List<CartModel> data =
              await CartService().delCart(event.data, event.idcart);
          emit(CartDelSuccess());
          emit(CartSuccess(data));
        } catch (e) {
          emit(CartDelFailed(e.toString()));
          emit(CartSuccess(event.data));
        }
      }
    });
  }
}
