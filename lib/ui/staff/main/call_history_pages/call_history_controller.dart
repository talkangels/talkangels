import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/staff/models/get_call_history_res_model.dart';

class CallHistoryController extends GetxController {
  bool isLoading = false;

  GetCallHistoryResModel getCallHistoryResModel = GetCallHistoryResModel();

  getCallHistoryApi() async {
    isLoading = true;

    ResponseItem result = await HomeRepoStaff.getCallHistory();
    // log("result---5------>${result.data}");

    if (result.status) {
      try {
        getCallHistoryResModel = GetCallHistoryResModel.fromJson(result.data);

        isLoading = false;
        update();
      } catch (e) {
        isLoading = false;
        update();
        log("-E----getCallHistoryApi------   $e");
      }
    } else {
      isLoading = false;
      update();
    }
  }
}
