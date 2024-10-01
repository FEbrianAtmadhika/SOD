import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sod_new/models/categorymodel.dart';
import 'package:sod_new/models/kacaumodel.dart';
import 'package:sod_new/models/productmodel.dart';
import 'package:sod_new/services/productservice.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductGetAll) {
        try {
          emit(ProductLoading());

          KacauModel res = await ProductServices().getAllProduct();

          emit(ProductSuccess(res.product!, res.category!));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      }
    });
  }
}
