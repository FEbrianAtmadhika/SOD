import 'package:flutter/material.dart';

class AddTransactionModel extends ChangeNotifier {
  int? totalprice;
  List<CheckedItemModel>? listitem;
  int? shippingprice;
  int? appfee;

  AddTransactionModel(
      {required this.totalprice,
      required this.appfee,
      required this.listitem,
      required this.shippingprice});
}

class CheckedItemModel extends ChangeNotifier {
  int? checkeditem;
  int? quantity;

  CheckedItemModel({required this.checkeditem, required this.quantity});
}
