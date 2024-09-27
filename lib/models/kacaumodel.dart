import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sod_new/models/categorymodel.dart';
import 'package:sod_new/models/productmodel.dart';

class KacauModel extends ChangeNotifier {
  List<ProductModel>? product;
  List<CategoryModel>? category;

  KacauModel({required this.category, required this.product});
}
