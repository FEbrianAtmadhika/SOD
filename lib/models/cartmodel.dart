import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  int? id;
  int? quantity;
  ProductCartModel? product;
  VariantCartModel? varian;
  CartModel(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.varian});

  CartModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    if (json['variant'] != null) {
      varian = VariantCartModel.fromJson(json['variant']);
    }
    if (json['variant']['product'] != null) {
      product = ProductCartModel.fromJson(json['variant']['product']);
    }
  }
}

class ProductCartModel extends ChangeNotifier {
  int? id;
  int? categoryid;
  String? name;
  String? slug;
  String? thumbnail;
  String? deskripsi;

  ProductCartModel(
      {required this.id,
      required this.name,
      required this.slug,
      required this.categoryid,
      required this.deskripsi,
      required this.thumbnail});
  ProductCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryid = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    deskripsi = json['description'];
  }
}

class VariantCartModel extends ChangeNotifier {
  int? id;
  int? productid;
  String? name;
  int? price;
  bool? isvisible;

  VariantCartModel(
      {required this.id,
      required this.isvisible,
      required this.name,
      required this.price,
      required this.productid});

  VariantCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['product_id'];
    name = json['name'];
    price = json['price'];
    isvisible = json['is_visible'] == 0 ? false : true;
  }
}
