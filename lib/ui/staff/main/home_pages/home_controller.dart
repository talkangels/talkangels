import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/reject_call_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/staff/models/active_status_res_model.dart';
import 'package:talkangels/ui/staff/models/add_call_history_res_model.dart';
import 'package:talkangels/ui/staff/models/get_staff_detail_res_model.dart';
import 'package:talkangels/ui/staff/models/send_withdraw_req_res_model.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  GetStaffDetailResModel getStaffDetailResModel = GetStaffDetailResModel();

  bool isRequestLoading = false;
  SendWithdrawReqResModel sendWithdrawReqResModel = SendWithdrawReqResModel();
  TextEditingController withdrawController = TextEditingController();
  List<dynamic> reviewList = [];

  bool isStatusLoading = false;
  ActiveStatusResModel activeStatusResModel = ActiveStatusResModel();

  bool isAddHistoryLoading = false;
  AddCallHistoryResModel addCallHistoryResModel = AddCallHistoryResModel();

  RejectCallResModel rejectCallResModel = RejectCallResModel();

  /// Get Staff Details
  getStaffDetailApi() async {
    isLoading = true;

    ResponseItem result = await HomeRepoStaff.getStaffDetail();
    // log("result---1-------> ${result.data}");
    reviewList = [];
    if (result.status) {
      try {
        getStaffDetailResModel = GetStaffDetailResModel.fromJson(result.data);

        getStaffDetailResModel.data?.reviews?.forEach((element) {
          element.userReviews?.forEach((element1) {
            reviewList.add(element1);
          });
        });

        reviewList.sort((a, b) => b.date!.compareTo(a.date!));

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
    // log("result---2-------> ${result.data}");

    if (result.status) {
      try {
        sendWithdrawReqResModel = SendWithdrawReqResModel.fromJson(result.data);

        /// get Staff details api
        await getStaffDetailApi();

        isRequestLoading = false;
        update();
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

  /// Active status Api
  activeStatusApi(String status) async {
    isStatusLoading = true;
    update();
    ResponseItem item = await HomeRepoStaff.activeStatusUpdate(status);
    // log("item---3------->${item.data}");
    if (item.status == true) {
      try {
        activeStatusResModel = ActiveStatusResModel.fromJson(item.data);

        isStatusLoading = false;
        update();
      } catch (e) {
        log("e=====activeStatusApi==========>$e");
        isStatusLoading = false;
        update();
      }
    } else {
      isStatusLoading = false;
      update();
    }
  }

  /// Add Call History Api
  addCallHistory(
      String angelId, String staffId, String callType, String minutes) async {
    isAddHistoryLoading = true;
    update();
    ResponseItem item =
        await HomeRepoStaff.addCallHistory(angelId, staffId, callType, minutes);
    log("item---4------->${item.data}");
    if (item.status == true) {
      try {
        addCallHistoryResModel = AddCallHistoryResModel.fromJson(item.data);

        isAddHistoryLoading = false;
        update();
      } catch (e) {
        log("e=======addCallHistory=======>$e");
        isAddHistoryLoading = false;
        update();
      }
    } else {
      isAddHistoryLoading = false;
      update();
    }
  }

  ///rejectCall
  rejectCall(String angelId, String userId, String type) async {
    update();
    ResponseItem item = await HomeRepoStaff.callReject(angelId, userId, type);
    log("item---4------->${item.data}");
    if (item.status == true) {
      try {
        rejectCallResModel = RejectCallResModel.fromJson(item.data);

        update();
      } catch (e) {
        log("e=======reject=======>$e");

        update();
      }
    } else {
      update();
    }
  }
}
