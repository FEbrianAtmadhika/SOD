import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  int? id;
  int? categoryid;
  String? name;
  String? slug;
  String? thumbnail;
  String? deskripsi;
  List<Gallery>? gallery;
  List<VariantsModel>? variants;

  ProductModel({
    required this.id,
    required this.categoryid,
    required this.name,
    required this.slug,
    required this.thumbnail,
    required this.deskripsi,
    required this.gallery,
    required this.variants,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryid = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    deskripsi = json['description'];
    if (json['images'] != null) {
      gallery =
          (json['images'] as List).map((i) => Gallery.fromJson(i)).toList();
    }

    if (json['variants'] != null) {
      variants = (json['variants'] as List)
          .map((v) => VariantsModel.fromJson(v))
          .toList();
    }
  }
}

class VariantsModel extends ChangeNotifier {
  int? id;
  int? product;
  String? name;
  int? price;
  bool? isVisible;
  StocksModel? stock;

  VariantsModel({
    required this.id,
    required this.product,
    required this.name,
    required this.price,
    required this.isVisible,
    required this.stock,
  });

  VariantsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product_id'];
    name = json['name'];
    price = json['price'];
    isVisible = json['is_visible'] == 0 ? false : true;

    if (json['variant_stocks'] != null && json['variant_stocks'].isNotEmpty) {
      stock = StocksModel.fromJson(json['variant_stocks'][0]);
    }
  }
}

class StocksModel extends ChangeNotifier {
  int? id;
  int? variant;
  int? quantity;
  int? available;

  StocksModel({
    required this.id,
    required this.variant,
    required this.quantity,
    required this.available,
  });

  StocksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variant = json['product_variant_id'];
    quantity = json['quantity'];
    available = json['available_stock'];
  }
}

class Gallery extends ChangeNotifier {
  int? id;
  int? productid;
  String? image;

  Gallery({
    required this.id,
    required this.productid,
    required this.image,
  });

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productid = json['product_id'];
    image = json['image'];
  }
}
