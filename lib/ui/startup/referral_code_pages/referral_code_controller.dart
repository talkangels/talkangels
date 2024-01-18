import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/ui/angels/main/drawer_pages/my_wallet_pages/my_wallet_screen_controller.dart';
import 'package:talkangels/ui/angels/models/referral_code_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';

class ReferralCodeController extends GetxController {
  MyWalletScreenController myWalletScreenController =
      Get.put(MyWalletScreenController());
  bool isLoading = false;
  ReferralCodeResponseModel referralCodeResponseModel =
      ReferralCodeResponseModel();

  referralCodeApi(String referCode) async {
    isLoading = true;

    ResponseItem result = await HomeRepoAngels.postReferralCodeApi(referCode);

    if (result.status == true) {
      try {
        if (result.data != null) {
          referralCodeResponseModel =
              ReferralCodeResponseModel.fromJson(result.data);

          if (referralCodeResponseModel.status == 200) {
            ///API calling _Add wallet Amount
            myWalletScreenController.addMyWalletAmountApi(
              "50",
              "REFER_$referCode",
            );
            Get.offAllNamed(Routes.homeScreen);

            showAppSnackBar(AppString.referralCodeApplied);
          } else if (referralCodeResponseModel.status == 400) {
            showAppSnackBar(referralCodeResponseModel.message ?? '');
            Get.offAllNamed(Routes.homeScreen);
          } else {
            log("referralCodeResponseModel.message   ${referralCodeResponseModel.status}  ${referralCodeResponseModel.message}");
          }
        }

        isLoading = false;
        update();
      } catch (e) {
        log("-----e-----   $e");
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
  }
}
