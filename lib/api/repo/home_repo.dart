import 'dart:developer';

import 'package:talkangels/api/api_helper.dart';
import 'package:talkangels/const/request_constant.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/const/shared_prefs.dart';

///Angels
class HomeRepoAngels {
  static Future<ResponseItem> getAngleAPi() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.getAngle;

    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Get Single Angel Data Api
  static Future<ResponseItem> getSingleAngleAPi(String angelId) async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.getSingleAngleDetails + angelId;

    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  static Future<ResponseItem> callApi(String angleId, String userId) async {
    ResponseItem result;
    Map<String, dynamic> params = {
      "angel_id": angleId,
      "user_id": userId,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.callAngle;

    result = await BaseApiHelper.postRequestToken(requestUrl, params);
    return result;
  }

  /// add wallet amount api
  static Future<ResponseItem> walletApi(String amount, String paymentId) async {
    ResponseItem result;
    Map<String, dynamic> params = {
      "user_id": PreferenceManager().getId().toString(),
      "amount": amount,
      "payment_id": paymentId,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.angleWallet;

    result = await BaseApiHelper.postRequestToken(requestUrl, params);
    return result;
  }

  /// get user details
  static Future<ResponseItem> getUserDetailsAPi() async {
    ResponseItem result;
    String userId = PreferenceManager().getId();

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.getUserDetails + userId;

    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// get all recharge list
  static Future<ResponseItem> getAllRechargesApi() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.getRechargeList;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// post referral code
  static Future<ResponseItem> postReferralCodeApi(String referCode) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user_id": "${PreferenceManager().getId() ?? ''}",
      "refer_code": referCode,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.postReferralCode;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }

  /// post Rating code
  static Future<ResponseItem> postRatingApi(String angelId, String rating, String comment) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user_id": "${PreferenceManager().getId() ?? ''}",
      "angel_id": angelId,
      "rating": rating,
      "comment": comment
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.postRating;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }

  /// Post Report a Problem
  static Future<ResponseItem> postReportAProblemApi(String comment) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user": "${PreferenceManager().getId() ?? ''}",
      "comment": comment,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesAngels.postReportAProblem;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }
}

///Staff
class HomeRepoStaff {
  /// Get staff Details
  static Future<ResponseItem> getStaffDetail() async {
    ResponseItem result;
    String userId = PreferenceManager().getId().toString();

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.getStaffDetails + userId;
    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }

  /// Get Call History

  static Future<ResponseItem> getCallHistory() async {
    ResponseItem result;

    String userId = PreferenceManager().getId().toString();

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.getStaffCallHistory + userId;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }

  /// Post Send Withdraw Request
  static Future<ResponseItem> sendWithdrawRequest(String amount) async {
    ResponseItem result;
    String userId = PreferenceManager().getId().toString();

    Map<String, dynamic> requestData = {
      "staffId": userId,
      "request_amount": amount,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.sendWithdrawRequest;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }

  /// Put Active Status

  static Future<ResponseItem> activeStatusUpdate(String status) async {
    ResponseItem result;
    String userId = PreferenceManager().getId().toString();

    Map<String, dynamic> requestData = {
      "active_status": status,
      // "Online", "Offline"
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.activeStatus + userId;
    result = await BaseApiHelper.putActiveStatue(requestUrl, requestData);
    return result;
  }

  /// Add Call History

  static Future<ResponseItem> addCallHistory(String angelId, String staffId, String callType, String minutes) async {
    ResponseItem result;
    String userId = PreferenceManager().getId().toString();

    Map<String, dynamic> requestData = {
      "staff_id": staffId,
      "user_id": angelId,
      "call_type": callType,
      "seconds": minutes,
    };
    log("requestData--------------> ${requestData}");

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.addCallHistory;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    log("result--------------> ${result.data}");
    return result;
  }

  ///call reject
  ///
  static Future<ResponseItem> callReject(String angelId, String userId, String type) async {
    ResponseItem result;

    Map<String, dynamic> requestData = {"angel_id": angelId, "user_id": userId, "type": type};
    log("requestData--------------> ${requestData}");

    String requestUrl = AppUrls.BASE_URL + CommonApis.rejectCall;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    log("result--------------> ${result.data}");

    return result;
  }

  /// Post Report a Problem _Staff
  static Future<ResponseItem> postReportAProblemStaffApi(String comment) async {
    ResponseItem result;
    Map<String, dynamic> requestData = {
      "user": "${PreferenceManager().getId() ?? ''}",
      "comment": comment,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNamesStaff.postReportProblemStaff;
    result = await BaseApiHelper.postRequestToken(requestUrl, requestData);
    return result;
  }
}
