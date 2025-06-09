import 'package:kan_kardesi/models/blog/blog_model.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';

class HomeModel {
  List<BlogModel> blogs;
  List<BloodRequestModel> requests;

  HomeModel({
    required this.blogs,
    required this.requests,
  });
}
