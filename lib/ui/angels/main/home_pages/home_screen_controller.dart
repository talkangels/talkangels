import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/angle_call_res_model.dart';
import 'package:talkangels/ui/angels/models/angle_list_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/angels/models/user_details_res_model.dart';
import 'package:talkangels/ui/angels/main/home_pages/calling_screen_controller.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/shared_prefs.dart';

class HomeController extends GetxController {
  GetAngleListResModel resModel = GetAngleListResModel();
  CallingScreenController callingScreenController =
      Get.put(CallingScreenController());

  AngleCallResModel angleCallResModel = AngleCallResModel();

  UserDetailsResponseModel userDetailsResModel = UserDetailsResponseModel();

  bool isLoading = true;
  bool isUserLoading = true;
  bool isCallLoading = false;
  Datum? selectedAngle;
  setAngle(Datum value) {
    selectedAngle = value;
    update();
  }

  homeAngleApi() async {
    isLoading = true;
    update();
    log("TOKEN---------->${PreferenceManager().getToken()}");
    ResponseItem item = await HomeRepo.getAngleAPi();
    log("item---------->${item.data}");
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
  }

  angleCallingApi(String angleId, String userId) async {
    isCallLoading = true;
    update();
    log("angleId---------->$angleId");
    ResponseItem item = await HomeRepo.callApi(angleId, userId);
    log("item---------->${item.status}");
    log("item---------->${item.data}");
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

      // log("res----->${resModel.data}");
    } else {
      isCallLoading = false;
      update();
    }
  }

  ///

  userDetailsApi() async {
    isUserLoading = true;
    update();
    ResponseItem item = await HomeRepo.getUserDetailsAPi();
    log("item---------->${item.status}");
    log("item---------->${item.data}");
    if (item.status == true) {
      try {
        userDetailsResModel = UserDetailsResponseModel.fromJson(item.data);
        log("UserDetailsResponseModel===>    ${item.data!}");
        isUserLoading = false;
        update();
      } catch (e) {
        log("e===============>$e");
        isUserLoading = false;
        update();
      }

      log("res----->${resModel.data}");
    } else {
      isUserLoading = false;
      update();
    }
  }
}
