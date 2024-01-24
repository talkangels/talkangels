import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/angle_call_res_model.dart';
import 'package:talkangels/ui/angels/models/angle_list_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/angels/models/delete_user_res_model.dart';
import 'package:talkangels/ui/angels/models/user_details_res_model.dart';
import 'package:talkangels/ui/angels/main/home_pages/calling_screen_controller.dart';
import 'package:talkangels/const/app_routes.dart';

class HomeScreenController extends GetxController {
  CallingScreenController callingScreenController =
      Get.put(CallingScreenController());
  GetAngleListResModel resModel = GetAngleListResModel();
  AngleCallResModel angleCallResModel = AngleCallResModel();
  UserDetailsResponseModel userDetailsResModel = UserDetailsResponseModel();
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  bool isUserLoading = true;
  bool isCallLoading = false;
  bool isDelete = false;
  DeleteAngelsResModel deleteAngelsResModel = DeleteAngelsResModel();
  bool isSearch = false;
  String? searchValue;

  AngleData? selectedAngle;
  setAngle(AngleData value) {
    selectedAngle = value;
    update();
  }

  homeAngleApi({bool isSearched = false, String? value}) async {
    isLoading = true;
    update();
    ResponseItem item = await HomeRepoAngels.getAngleAPi(
        isSearched: isSearched, value: value.toString());
    if (item.status == true) {
      try {
        resModel = GetAngleListResModel.fromJson(item.data);
        isLoading = false;
        update();
      } catch (e) {
        log("e========error=======>$e");
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
    return resModel;
  }

  // searchData(String text) {
  //   resModel.data = [];
  //   if (text.isNotEmpty || text != "") {
  //     resModel.data?.forEach((element) {
  //       if (element.name
  //           .toString()
  //           .trim()
  //           .toLowerCase()
  //           .contains(text.toString().trim().toLowerCase())) {
  //         resModel.data?.add(element);
  //       }
  //     });
  //   }
  //
  //   log('==================>>>>>>>>${resModel.data}');
  //   update();
  // }

  angleCallingApi(String angleId, String userId) async {
    isCallLoading = true;
    update();
    log("angleId---------->$angleId");
    ResponseItem item = await HomeRepoAngels.callApi(angleId, userId);
    // log("item---------->${item.data}");
    if (item.status == true) {
      try {
        angleCallResModel = AngleCallResModel.fromJson(item.data);
        log("angleCallResModel---->${angleCallResModel.data!.agoraInfo!.token}");
        log("angleCallResModel---->${selectedAngle!.id}");

        Get.toNamed(Routes.callingScreen, arguments: {
          "selectedAngle": selectedAngle,
          "angleCallResModel": angleCallResModel,
        });

        isCallLoading = false;
        update();
      } catch (e) {
        log("e----->$e");
        isCallLoading = false;
        update();
      }
    } else {
      isCallLoading = false;
      update();
    }
  }

  ///

  userDetailsApi() async {
    isUserLoading = true;
    update();
    ResponseItem item = await HomeRepoAngels.getUserDetailsAPi();
    if (item.status == true) {
      try {
        userDetailsResModel = UserDetailsResponseModel.fromJson(item.data);
        isUserLoading = false;
        update();
      } catch (e) {
        log("e===============>$e");
        isUserLoading = false;
        update();
      }
    } else {
      isUserLoading = false;
      update();
    }
  }

  /// Delete Account Api
  deleteAccountApi() async {
    isDelete = true;
    update();
    ResponseItem item = await HomeRepoAngels.deleteAngelApi();
    if (item.status == true) {
      try {
        deleteAngelsResModel = DeleteAngelsResModel.fromJson(item.data);
        isDelete = false;
        Get.offAllNamed(Routes.loginScreen);
        update();
      } catch (e) {
        log("e===============>$e");
        isDelete = false;
        update();
      }
    } else {
      isDelete = false;
      update();
    }
  }
}
