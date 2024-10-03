import 'package:flutter/material.dart';

// Model untuk Transaction
class TransactionModel extends ChangeNotifier {
  int? id;
  int? userId;
  int? totalPrice;
  int? shippingPrice;
  int? appFee;
  String? status;
  String? code;
  String? address;
  List<DetailTransactionModel>? details;
  String? payment;
  UserModel? user;

  TransactionModel(
      {this.id,
      this.userId,
      this.totalPrice,
      this.shippingPrice,
      this.appFee,
      this.status,
      this.code,
      this.details,
      this.payment,
      this.user});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    appFee = json['app_fee'];
    status = json['status'];
    code = json['code'];
    address = json['address'];
    details = (json['details'] as List)
        .map((detail) => DetailTransactionModel.fromJson(detail))
        .toList();
    payment = json['payment'];
    if (json['user'] != null) {
      user = UserModel.fromJson(json['user']);
    }
  }
}

// Model untuk DetailTransaction
class DetailTransactionModel extends ChangeNotifier {
  int? id;
  int? transactionId;
  int? variantId;
  int? quantity;
  int? price;
  int? capitalPrice;
  VariantModel? variant;

  DetailTransactionModel({
    this.id,
    this.transactionId,
    this.variantId,
    this.quantity,
    this.price,
    this.capitalPrice,
    this.variant,
  });

  factory DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    return DetailTransactionModel(
      id: json['id'],
      transactionId: json['transaction_id'],
      variantId: json['variant_id'],
      quantity: json['quantity'],
      price: json['price'],
      capitalPrice: json['capital_price'],
      variant: VariantModel.fromJson(json['variant']),
    );
  }
}

// Model untuk Variant
class VariantModel extends ChangeNotifier {
  int? id;
  int? productId;
  String? name;
  int? price;
  bool? isVisible;
  int? availableStockCount;
  ProductModel? product;

  VariantModel({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.isVisible,
    this.availableStockCount,
    this.product,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      isVisible: json['is_visible'] == 1,
      availableStockCount: json['available_stock_count'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

// Model untuk Product
class ProductModel extends ChangeNotifier {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  String? thumbnail;
  String? description;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.slug,
    this.thumbnail,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      slug: json['slug'],
      thumbnail: json['thumbnail'],
      description: json['description'],
    );
  }
}

class UserModel extends ChangeNotifier {
  int? id;
  String? name;
  String? email;

  UserModel({required this.email, required this.id, required this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}
