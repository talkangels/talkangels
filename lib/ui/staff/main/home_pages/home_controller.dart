import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/staff/models/get_staff_detail_res_model.dart';
import 'package:talkangels/ui/staff/models/send_withdraw_req_res_model.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  GetStaffDetailResModel getStaffDetailResModel = GetStaffDetailResModel();

  bool isRequestLoading = false;
  SendWithdrawReqResModel sendWithdrawReqResModel = SendWithdrawReqResModel();
  TextEditingController withdrawController = TextEditingController();

  /// Get Staff Details
  getStaffDetailApi() async {
    isLoading = true;

    ResponseItem result = await HomeRepoStaff.getStaffDetail();
    log("result---1-------> ${result.data}");

    if (result.status) {
      try {
        getStaffDetailResModel = GetStaffDetailResModel.fromJson(result.data);
        isLoading = false;
        update();
      } catch (e) {
        isLoading = false;
        update();
        log("-E----getStaffDetailApi----  $e");
      }
    } else {
      isLoading = false;
      update();
    }
  }

  /// Post WithDraw Request

  sendWithdrawRequest(String amount) async {
    isRequestLoading = true;

    ResponseItem result = await HomeRepoStaff.sendWithdrawRequest(amount);
    log("result---2-------> ${result.data}");

    if (result.status) {
      try {
        sendWithdrawReqResModel = SendWithdrawReqResModel.fromJson(result.data);
        // type 'int' is not a subtype of type 'String' in type cast
        // type 'String' is not a subtype of type 'int?'

        try {
          /// get Staff details api
          await getStaffDetailApi();
          log("qrfev");
        } catch (e) {
          log("ERRER  =====    $e");
        }
        isRequestLoading = false;
        update();
        log("uk,m,m");
      } catch (e) {
        isRequestLoading = false;
        update();
        log("-E----sendWithdrawRequest----  $e");
      }
    } else {
      isRequestLoading = false;
      update();
    }
  }
}
