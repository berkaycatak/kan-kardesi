// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blog/blog_model.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/home/home_model.dart';
import 'package:kan_kardesi/services/request/request_service.dart';

class HomeRepository {
  final RequestServices _requestServices = RequestServices();

  Future<HomeModel?> getHome({
    required BuildContext context,
  }) async {
    try {
      dynamic response = await _requestServices.sendRequest(
        context: context,
        path: "home",
        isToken: true,
        payload: {},
      );

      if (response == null) return null;

      List<dynamic> requestsRespose = response["blood_requests"];
      List<dynamic> blogsRespose = response["blogs"];

      List<BloodRequestModel> requests = [];
      List<BlogModel> blogs = [];

      for (dynamic blog in blogsRespose) {
        blogs.add(BlogModel.fromJson(blog));
      }

      for (dynamic request in requestsRespose) {
        requests.add(BloodRequestModel.fromJson(request));
      }

      HomeModel homeModel = HomeModel(blogs: blogs, requests: requests);

      return homeModel;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
