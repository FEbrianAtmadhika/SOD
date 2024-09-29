import 'package:flutter/material.dart';
import 'package:sod_new/models/subdistrictmodel.dart';

class AddressModel extends ChangeNotifier {
  int? id;
  int? userId;
  int? subDistrictId;
  String? address;
  String? latitude;
  String? longitude;
  String? type;
  String? receiverName;
  String? receiverPhone;
  String? status;
  SubDistrict? subDistrict;

  AddressModel({
    this.id,
    this.userId,
    this.subDistrictId,
    this.address,
    this.latitude,
    this.longitude,
    this.type,
    this.receiverName,
    this.receiverPhone,
    this.status,
    this.subDistrict,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      subDistrictId: json['sub_district_id'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: json['type'],
      receiverName: json['receiver_name'],
      receiverPhone: json['receiver_phone'],
      status: json['status'],
      subDistrict: json['sub_district'] != null
          ? SubDistrict.fromJson(json['sub_district'])
          : null,
    );
  }
}
