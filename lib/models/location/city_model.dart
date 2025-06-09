class CityModel {
  int? id;
  String? name;

  CityModel({
    this.id,
    this.name,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['il_adi'] = name;
    return data;
  }
}
