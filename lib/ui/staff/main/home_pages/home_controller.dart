import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/staff/models/get_staff_detail_res_model.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  GetStaffDetailResModel getStaffDetailResModel = GetStaffDetailResModel();

  getStaffDetailApi() async {
    isLoading = true;

    ResponseItem result = await HomeRepoStaff.getStaffDetail();
    log("result---1------->${result.data}");

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
}
