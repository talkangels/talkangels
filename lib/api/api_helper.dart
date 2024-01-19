import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:talkangels/api/api_exception.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:http/http.dart' as http;
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/const/shared_prefs.dart';

/// Angels
class BaseApiHelper {
  ///===========
  static Future<ResponseItem> postRequest(
      String requestUrl, Map<String, dynamic> requestData) async {
    log("request:$requestUrl");
    log("body:${json.encode(requestData)}");
    return await http
        .post(
          Uri.parse(requestUrl),
          body: requestData,
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  ///===========
  static Future<ResponseItem> getRequest(String requestUrl) async {
    log("request:$requestUrl");
    String token = PreferenceManager().getToken().toString();

    return await http
        .get(Uri.parse(requestUrl), headers: {"Authorization": token})
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  ///===========
  static Future<ResponseItem> postRequestToken(
      String requestUrl, Map<String, dynamic> requestData) async {
    String token = PreferenceManager().getToken().toString();
    log("request 1:${requestUrl}   ${requestUrl.runtimeType}");
    log("request 21:${requestData["staffId"]}  ${requestData["staffId"].runtimeType}");
    log("request 22:${requestData["request_amount"]}  ${requestData["request_amount"].runtimeType}");
    log("request 3:${token}    ${token.runtimeType}");

    return await http
        .post(Uri.parse(requestUrl),
            body: requestData, headers: {"Authorization": token})
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  ///===========
  static Future onValue(http.Response response) async {
    log(response.statusCode.toString(), name: "RESPONSE STATUSCODE");
    log(response.body.toString(), name: "RESPONSE BODY");

    final ResponseItem result =
        ResponseItem(status: false, message: "Something went wrong.");

    dynamic data = json.decode(response.body);
    log("responseCode---: ${response.statusCode}", name: "response");
    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.data = data;
      log("Success");
    } else if (response.statusCode == 400) {
      showAppSnackBar("Invalid Status");
      Get.back();
    } else {
      result.message = data["msg"] ?? "";
      print("result.message --> ${result.message}");
      log("response: $data");
    }

    return result;
  }

  ///===========
  static onError(error) {
    log("Error caused: $error");
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      // message = ResponseException("Something wrong in response.").toString() +
      //     error.toString();
    }
    return ResponseItem(data: null, message: message, status: false);
  }
}
