import 'dart:developer';
import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/ui/angels/models/add_wallet_ballence_res_model.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/angels/main/home_pages/home_screen_controller.dart';

class MyWalletScreenController extends GetxController {
  HomeScreenController homeController = Get.put(HomeScreenController());
  AddWalletBallanceResponseModel addWalletBallanceResponseModel =
      AddWalletBallanceResponseModel();
  bool isLoading = false;

  addMyWalletAmountApi(String amount, String paymentId) async {
    isLoading = true;
    update();

    ResponseItem item = await HomeRepoAngels.walletApi(amount, paymentId);
    if (item.status == true) {
      try {
        addWalletBallanceResponseModel =
            AddWalletBallanceResponseModel.fromJson(item.data);

        /// Api calling
        await homeController.userDetailsApi();

        isLoading = false;
        update();
      } catch (e) {
        log("e----->$e");
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
  }
}
