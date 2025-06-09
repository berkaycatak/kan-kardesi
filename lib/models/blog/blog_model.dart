import 'package:kan_kardesi/models/user/user_model.dart';

class BlogModel {
  int? id;
  String? title;
  String? slug;
  String? image;
  String? description;
  String? shortDescription;
  String? status;
  int? createdUserId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  BlogModel(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.description,
      this.shortDescription,
      this.status,
      this.createdUserId,
      this.createdAt,
      this.updatedAt,
      this.user});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    description = json['description'];
    shortDescription = json['short_description'];
    status = json['status'];
    createdUserId = json['created_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['status'] = status;
    data['created_user_id'] = createdUserId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
