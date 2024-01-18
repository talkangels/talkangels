import 'dart:developer';

import 'package:get/get.dart';
import 'package:talkangels/api/repo/home_repo.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/ui/angels/models/add_rating_res_model.dart';
import 'package:talkangels/ui/angels/models/single_angel_res_model.dart';

class PersonDetailsScreenController extends GetxController {
  bool isLoading = false;
  AddRatingResModel addRatingResModel = AddRatingResModel();

  bool isDetailsLoading = false;
  GetSingleAngelResModel getSingleAngelResModel = GetSingleAngelResModel();

  getSingleAngelData(String angelId) async {
    isDetailsLoading = true;
    ResponseItem result = await HomeRepoAngels.getSingleAngleAPi(angelId);
    // log("response=====>>   $result");
    log("result.statusCode=====>>   ${result.statusCode}");

    if (result.status) {
      try {
        getSingleAngelResModel = GetSingleAngelResModel.fromJson(result.data);
        log("SUCCESS===getAllRechargeResModel====>   ${getSingleAngelResModel.data}");

        isDetailsLoading = false;
        update();
      } catch (e) {
        log("e----------   $e");
        isDetailsLoading = false;
        update();
      }
    } else {
      showAppSnackBar("${result.message}");
    }
  }

  addRatingApi(String angelId, String rating, String comment) async {
    isLoading = true;

    ResponseItem result =
        await HomeRepoAngels.postRatingApi(angelId, rating, comment);

    log("RESULT====== $result");
    log("RESPONSE=====>>>>>   ${result.statusCode}");
    if (result.status) {
      try {
        addRatingResModel = AddRatingResModel.fromJson(result.data);
        log("SUCCESS===getAllRechargeResModel====>   ${addRatingResModel.message}");

        await getSingleAngelData(angelId);
        // homeController.homeAngleApi();
        Get.back();
        isLoading = false;
        update();
      } catch (e) {
        log("e----------   $e");
        isLoading = false;
        update();
      }
    } else {
      showAppSnackBar("${result.message}");
    }
  }
}
