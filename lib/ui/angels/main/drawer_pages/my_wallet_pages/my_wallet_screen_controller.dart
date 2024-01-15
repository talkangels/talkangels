import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/ui/angels/models/add_wallet_ballence_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/angels/main/home_pages/home_screen_controller.dart';

class MyWalletScreenController extends GetxController {
  HomeController homeController = Get.find();
  bool isLoading = false;

  addMyWalletAmountApi(String amount, String paymentId) async {
    isLoading = true;
    update();

    ResponseItem item = await HomeRepo.walletApi(amount, paymentId);
    log("item---------->${item.status}");
    log("item---------->${item.data}");
    if (item.status == true) {
      try {
        AddWalletBallanceResponseModel addWalletBallanceResponseModel =
            AddWalletBallanceResponseModel.fromJson(item.data);
        log("addWalletBallanceResponseModel---->${addWalletBallanceResponseModel.data!}");
        homeController.userDetailsApi();

        isLoading = false;
        update();
      } catch (e) {
        log("e----->$e");
        isLoading = false;
        update();
      }

      // log("res----->${resModel.data}");
    } else {
      isLoading = false;
      update();
    }
  }
}
