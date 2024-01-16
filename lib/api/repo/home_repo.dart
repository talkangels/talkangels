import 'dart:developer';

import 'package:talkangels/api/api_helper.dart';
import 'package:talkangels/const/request_constant.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/const/shared_prefs.dart';

class HomeRepo {
  static Future<ResponseItem> getAngleAPi() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL + MethodNames.getAngle;

    result = await BaseApiHelper.getRequest(requestUrl);
    // log("result-----asasas------->${result}");
    return result;
  }

  /// Get Single Angel Data Api
  static Future<ResponseItem> getSingleAngleAPi(String angelId) async {
    ResponseItem result;

    String requestUrl =
        AppUrls.BASE_URL + MethodNames.getSingleAngleDetails + angelId;

    result = await BaseApiHelper.getRequest(requestUrl);
    // log("result-----asasas------->${result}");
    return result;
  }

  static Future<ResponseItem> callApi(String angleId, String userId) async {
    ResponseItem result;
    Map<String, dynamic> params = {
      "angel_id": angleId,
      "user_id": userId,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.callAngle;

    result = await BaseApiHelper.postRequestToken(requestUrl, params);
    // log("result------------>${result}");
    return result;
  }

  /// add wallet amount api
  static Future<ResponseItem> walletApi(String amount, String paymentId) async {
    ResponseItem result;
    Map<String, dynamic> params = {
      "user_id": PreferenceManager().getId(),
      "amount": amount,
      "payment_id": paymentId,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.angleWallet;

    result = await BaseApiHelper.postRequestToken(requestUrl, params);
    return result;
  }

  /// get user details
  static Future<ResponseItem> getUserDetailsAPi() async {
    ResponseItem result;
    String userId = PreferenceManager().getId();

    String requestUrl = AppUrls.BASE_URL + MethodNames.getUserDetails + userId;

    result = await BaseApiHelper.getRequest(requestUrl);
    // log("result----getUserDetailsAPi-------->${result}");
    return result;
  }

  /// get all recharge list
  static Future<ResponseItem> getAllRechargesApi() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL + MethodNames.getRechargeList;
    result = await BaseApiHelper.getRequest(requestUrl);
    // log("result----getAllRechargesApi-------->${result}");
    return result;
  }

  /// post referral code
  static Future<ResponseItem> postReferralCodeApi(String referCode) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user_id": "${PreferenceManager().getId() ?? ''}",
      "refer_code": referCode,
      // "refer_code": "Vul9Pygv"
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.postReferralCode;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }

  /// post Rating code
  static Future<ResponseItem> postRatingApi(
      String angelId, String rating, String comment) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user_id": "${PreferenceManager().getId() ?? ''}",
      "angel_id": angelId,
      // "angel_id": "659cdf9a57a5087d111c47a4",
      "rating": rating,
      "comment": comment
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.postRating;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }
}
