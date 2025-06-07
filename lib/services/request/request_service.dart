// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/utils/components/app/adaptive/adaptive_action.dart';
import 'package:kan_kardesi/utils/constants/constants.dart';
import 'package:kan_kardesi/models/app/file_model.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/enums/shared_preferences_enums.dart';
import 'package:path/path.dart';

class RequestServices {
  Future<dynamic> sendRequest({
    required BuildContext context,
    required String path,
    required Map payload,
    required bool isToken,
    Map<String, List<FileModel>>? files,
    String? fullPath,
  }) async {
    try {
      const storage = FlutterSecureStorage();

      Response response;
      Map<String, String> myHeader = {
        'Accept': "application/json",
      };

      late Uri uri;
      if (fullPath != null) {
        uri = Uri.parse(fullPath);
      } else {
        uri = Uri.parse(Constants.API_URL + path);
      }

      String? fcmToken = GlobalVariables.playerID ?? "";
      payload["playerId"] = fcmToken;

      if (isToken) {
        String? authToken = await storage.read(
          key: SharedPreferencesKeyEnums.token.name,
        );

        myHeader = {
          'Accept': "application/json",
          "Authorization": "Bearer $authToken",
        };
      }

      if (kDebugMode) {
        print("\n");
        print("\n-------------------- REQUEST --------------------");
        print("PAYLOADS : $payload");
        print("\n");
        print(Constants.API_URL + path);
      }
      http.MultipartRequest m_request;

      if (files != null) {
        if (files.isNotEmpty) {
          m_request = http.MultipartRequest("POST", uri);

          files.forEach((key, value) async {
            value.forEach((item) async {
              if (item.devicePath != null) {
                File file = File(item.devicePath!);
                var stream = http.ByteStream(DelegatingStream(file.openRead()));
                var length = await file.length();
                var multipartFile = http.MultipartFile(
                  value.isEmpty ? key : "$key[]",
                  stream,
                  length,
                  filename: basename(file.path),
                );
                m_request.files.add(multipartFile);
              }
            });
          });

          Map<String, String> newPayload = payload.map((key, value) {
            return MapEntry(key, value.toString());
          });

          m_request.fields.addAll(newPayload);
          m_request.headers.addAll(myHeader);
          var response = await m_request.send();
          var responseData = await response.stream.toBytes();
          // var responseString = String.fromCharCodes(responseData);
          Response responseBytes = http.Response.bytes(
            responseData,
            response.statusCode,
          );
          dynamic responseJson = returnResponse(
            responseBytes,
            context,
          );

          if (responseJson == null) return null;

          return responseJson;
        }
      } else {
        response = await http.post(uri, headers: myHeader, body: payload);

        if (kDebugMode) {
          print("STATUS: ${response.statusCode}");
          print("\n-------------------- REQUEST --------------------\n");
        }

        dynamic responseJson = returnResponse(
          response,
          context,
        );

        if (responseJson == null) return null;

        return responseJson;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
    return null;
  }

  dynamic returnResponse(http.Response response, context,
      {bool showError = true}) async {
    Map<String, dynamic> convertedResponse = jsonDecode(response.body);
    //List<Widget> messages = errorToWidget(errors);
    if (showError == false) {
      return convertedResponse;
    }

    switch (response.statusCode) {
      case 200:
        if (convertedResponse['error'] == 1) {
          return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog.adaptive(
                content: Text(
                  convertedResponse["msg"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                actions: [
                  adaptiveAction(
                    context: context,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Kapat",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        }
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        break;
      case 401:
        const storage = FlutterSecureStorage();
        await storage.delete(key: SharedPreferencesKeyEnums.token.name);
        GlobalVariables.userModel = null;
        RouterService.goNamed(
          context: context,
          route: RouteConstants().welcome,
        );
        return null;
      case 403:
        break;
      case 500:
      case 302:
      case 422:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              actions: [
                adaptiveAction(
                  context: context,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Kapat",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              content: Text(
                convertedResponse["msg"] ?? "Sunucuya şu anda ulaşılamıyor.",
              ),
            );
          },
        );
        break;
      default:
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              actions: [
                adaptiveAction(
                  context: context,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Kapat",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              content: const Text(
                "Sunucuya şu anda ulaşılamıyor.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        );
        break;
    }
  }

  List<Text> errorToWidget(Map<String, dynamic> errors) {
    List<Text> messages = [];

    try {
      for (var element in errors.entries) {
        List<dynamic> value = element.value;
        for (var valueText in value) {
          Text text = Text(
            "- $valueText",
            style: const TextStyle(color: Colors.white),
          );
          messages.add(text);
        }
      }
      return messages;
    } catch (e) {
      return [
        const Text("Modül şu anda hizmet veremiyor."),
      ];
    }
  }
}
