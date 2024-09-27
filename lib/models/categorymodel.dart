import 'package:flutter/material.dart';

class CategoryModel extends ChangeNotifier {
  int? id;
  String? name;
  String? slug;
  String? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
}
