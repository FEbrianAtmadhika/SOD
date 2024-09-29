import 'package:sod_new/models/districtinfomodel.dart';

class SubDistrict {
  int? id;
  String? name;
  int? districtId;
  int? fee;
  String? description;
  String? status;
  DistrictInfo? districtInfo;

  SubDistrict({
    this.id,
    this.name,
    this.districtId,
    this.fee,
    this.description,
    this.status,
    this.districtInfo,
  });

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      id: json['id'],
      name: json['name'],
      districtId: json['district_id'],
      fee: json['fee'],
      description: json['description'],
      status: json['status'],
      districtInfo: json['district'] != null
          ? DistrictInfo.fromJson(json['district'])
          : null,
    );
  }
}
