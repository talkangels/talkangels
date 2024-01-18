import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/const/extentions.dart';
import 'app_button.dart';

Future<dynamic> appDialogBox(BuildContext context,
    {required double w, required double h, bool? barrierDismissible}) {
  return showDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.08),
      contentPadding: EdgeInsets.all(w * 0.05),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.zero,
            height: h * 0.4,
            width: w * 0.9,
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: h * 0.12,
                  width: w * 0.3,
                  child: assetImage(AppAssets.successAnimationAssets,
                      fit: BoxFit.cover),
                ),
                const Spacer(),
                AppString.sucess.regularLeagueSpartan(
                    fontColor: blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                (h * 0.01).addHSpace(),
                AppString
                    .yourSelectedTalktimeRechargeIsDoneSuccessfullyContinueUsingyourFavouriteAppHaveaNiceDay
                    .regularLeagueSpartan(
                        fontColor: greyFontColor,
                        fontSize: 15,
                        textAlign: TextAlign.center),
                (h * 0.04).addHSpace(),
                AppButton(
                  onTap: () {
                    Get.back();
                  },
                  color: redFontColor,
                  child: AppString.okayThanks.regularLeagueSpartan(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Future<dynamic> paymentSuccessDialogBox(BuildContext context,
    {required double w,
    required double h,
    bool? barrierDismissible,
    String? message}) {
  return showDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.08),
      contentPadding: EdgeInsets.all(w * 0.05),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.zero,
            height: h * 0.4,
            width: w * 0.9,
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: h * 0.12,
                  width: w * 0.3,
                  child: assetImage(AppAssets.successAnimationAssets,
                      fit: BoxFit.cover),
                ),
                const Spacer(),
                AppString.sucess.regularLeagueSpartan(
                    fontColor: blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                (h * 0.01).addHSpace(),
                AppString
                    .amountSuccessfullyAddedInWalletContinueUsingYourFavouriteAppHaveANiceDay
                    .regularLeagueSpartan(
                        fontColor: greyFontColor,
                        fontSize: 15,
                        textAlign: TextAlign.center),
                (h * 0.04).addHSpace(),
                AppButton(
                  onTap: () {
                    Get.back();
                  },
                  color: redFontColor,
                  child: AppString.okayThanks.regularLeagueSpartan(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Future<dynamic> paymentFaildDialogBox(BuildContext context,
    {required double w,
    required double h,
    bool? barrierDismissible,
    String? description}) {
  return showDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.08),
      contentPadding: EdgeInsets.all(w * 0.05),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.zero,
            height: h * 0.4,
            width: w * 0.9,
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                    height: h * 0.12,
                    width: w * 0.3,
                    child: assetImage(AppAssets.exitAnimationAssets,
                        fit: BoxFit.cover)),
                const Spacer(),
                AppString.paymentFaild.regularLeagueSpartan(
                    fontColor: blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                (h * 0.01).addHSpace(),
                description!.regularLeagueSpartan(
                    fontColor: greyFontColor,
                    fontSize: 15,
                    textAlign: TextAlign.center),
                (h * 0.04).addHSpace(),
                AppButton(
                  onTap: () {
                    Get.back();
                  },
                  color: redFontColor,
                  child: AppString.okayThanks.regularLeagueSpartan(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
