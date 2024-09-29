class DistrictInfo {
  int? id;
  String? name;

  DistrictInfo({
    this.id,
    this.name,
  });

  factory DistrictInfo.fromJson(Map<String, dynamic> json) {
    return DistrictInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}
