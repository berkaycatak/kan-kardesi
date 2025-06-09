import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? cityId;
  CityModel? city;
  String? latitude;
  String? longitude;
  int? bloodTypeId;
  BloodTypeModel? bloodType;
  String? lastDonationDate;
  List<BloodRequestModel>? requests;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.cityId,
    this.city,
    this.latitude,
    this.longitude,
    this.bloodTypeId,
    this.bloodType,
    this.lastDonationDate,
    this.requests,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cityId = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bloodTypeId = json['blood_type_id'];
    if (bloodTypeId != null) {
      bloodType = GlobalVariables.bloodTypes.firstWhere(
        (bloodType) => bloodType.id == bloodTypeId,
      );
    }

    if (json['blood_requests'] != null) {
      requests = <BloodRequestModel>[];
      json['blood_requests'].forEach((v) {
        requests!.add(BloodRequestModel.fromJson(v));
      });
    }

    if (cityId != null) {
      city = GlobalVariables.cities.firstWhere(
        (city) => city.id == cityId,
      );
    }

    lastDonationDate = json['last_donation_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['blood_type_id'] = bloodTypeId;
    data['last_donation_date'] = lastDonationDate;
    if (requests != null) {
      data['blood_requests'] = requests!.map((v) => v.toJson()).toList();
    }

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
