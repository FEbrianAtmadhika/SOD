class DistrictInfoModel {
  int? id;
  String? name;

  DistrictInfoModel({
    this.id,
    this.name,
  });

  factory DistrictInfoModel.fromJson(Map<String, dynamic> json) {
    return DistrictInfoModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
