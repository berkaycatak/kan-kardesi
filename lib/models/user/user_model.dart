class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? latitude;
  String? longitude;
  int? bloodTypeId;
  String? lastDonationDate;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.latitude,
      this.longitude,
      this.bloodTypeId,
      this.lastDonationDate,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bloodTypeId = json['blood_type_id'];
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
