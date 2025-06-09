import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/models/user/user_model.dart';

class BloodRequestModel {
  int? id;
  int? userId;
  int? requiredBloodTypeId;
  int? unitsNeeded;
  int? city;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  BloodTypeModel? bloodType;
  UserModel? user;
  CityModel? cityData;

  BloodRequestModel(
      {this.id,
      this.userId,
      this.requiredBloodTypeId,
      this.unitsNeeded,
      this.city,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.bloodType,
      this.user,
      this.cityData});

  BloodRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requiredBloodTypeId = json['required_blood_type_id'];
    unitsNeeded = json['units_needed'];
    city = json['city'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodType = json['required_blood_type'] != null
        ? BloodTypeModel.fromJson(json['required_blood_type'])
        : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    cityData = json['city_data'] != null
        ? CityModel.fromJson(json['city_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['required_blood_type_id'] = requiredBloodTypeId;
    data['units_needed'] = unitsNeeded;
    data['city'] = city;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (bloodType != null) {
      data['required_blood_type'] = bloodType!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (cityData != null) {
      data['city_data'] = cityData!.toJson();
    }
    return data;
  }
}
