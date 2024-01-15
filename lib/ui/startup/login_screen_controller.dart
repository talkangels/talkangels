import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:talkangels/api/repo/auth_repo.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/models/response_item.dart';
import 'package:talkangels/ui/angels/models/user_login_res_model.dart';
import 'package:talkangels/models/whatsapp_login_res_model.dart';
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/ui/startup/referral_code_pages/referral_code_controller.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/shared_prefs.dart';

class LoginScreenController extends GetxController {
  ReferralCodeController referralCodeController =
      Get.put(ReferralCodeController());

  final _otplessFlutterPlugin = Otpless();
  String? phoneNumber;
  String? code;
  String? number;

  /// WhatsApp Login
  Future<void> isWhatsappInstalled() async {
    _otplessFlutterPlugin.isWhatsAppInstalled().then(
      (value) {
        if (!value) {
          showAppSnackBar(AppString.pleaseInstallTheWhatsapp);
        }
      },
    );
  }

  Future<void> startOtpless(String? referCode) async {
    await _otplessFlutterPlugin.hideFabButton();

    _otplessFlutterPlugin.openLoginPage((result) async {
      try {
        if (result['data'] != null) {
          WhatsappLoginResponseModel resData =
              WhatsappLoginResponseModel.fromJson(result['data']);
          phoneNumber = result['data']["mobile"]["number"];
          if (phoneNumber!.length > 10) {
            code = phoneNumber!.substring(0, 2);
            number = phoneNumber!.substring(2, phoneNumber!.length);
          } else {
            code = '';
            number = phoneNumber;
          }

          /// API signIn
          await signIn(
              name: resData.waName ?? '',
              mNo: number ?? '',
              cCode: code ?? '',
              fcm: PreferenceManager().getFCMNotificationToken() ?? '',
              referCode: referCode);
        }
      } catch (e) {
        log('----ERROR>>>$e');
      }
    });
  }

  /// API Calling

  RxBool isLoading = false.obs;

  Future<void> signIn(
      {String? name,
      String? mNo,
      String? cCode,
      String? fcm,
      String? referCode}) async {
    log("NAME  ${name}");
    log("MOBILENO  ${mNo}");
    log("COUNTRYCODE  ${cCode}");
    log("FCMTOKEN  ${fcm}");

    isLoading.value = true;
    ResponseItem result = ResponseItem(message: AppString.somethingWentWrong);
    result = await AuthRepo.userLogin(
      name.toString(),
      mNo.toString(),
      cCode.toString(),
      fcm.toString(),
    );

    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          UserLoginResponseModel userRest =
              UserLoginResponseModel.fromJson(result.data);

          if (userRest.status == 200) {
            PreferenceManager().setLogin(true);
            PreferenceManager().setName(userRest.data?.name ?? '');
            PreferenceManager()
                .setNumber(userRest.data?.mobileNumber.toString() ?? '');
            PreferenceManager().setId(userRest.data?.id ?? '');
            PreferenceManager().setToken(userRest.token ?? '');
            PreferenceManager().setUserDetails(jsonEncode(userRest.data) ?? '');

            PreferenceManager().setRole(userRest.data!.role ?? '');
            log("userRest.data!.role----->${userRest.data!.role}");
            if (userRest.data!.role == "user") {
              Get.offAllNamed(Routes.homeScreen);

              ///

              if (referCode == '') {
                log("==1===homescreen===");
                Get.offAllNamed(Routes.homeScreen);
              } else {
                log("=2=referred====");
                if (userRest.userType == "old") {
                  ///login
                  log("=5===aad referred===");
                  Get.offAllNamed(Routes.homeScreen);
                } else {
                  ///register
                  ///call post referralCode API
                  referralCodeController.referralCodeApi(referCode!);
                }
              }
            } else {
              Get.offAllNamed(Routes.bottomBarScreen);
            }
            showAppSnackBar(AppString.loginSuccessfully);

            ///input refer
            // referralCodeController.referralCodeApi(referCode!);

            log("$result", name: "RESULT");
            log("${result.data}", name: "RESULT_DATA");
            log("$userRest", name: "RESULT11111");
            log("${userRest.data}", name: "RESULT_DATA11111");

            userRest.data;
          } else {
            log('${userRest.message}', name: "userRest.message");
          }
          update();
        }
      } else {
        log("ERROR  2======>  ${result.message}");
        showAppSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log("ERROR  1======>  $e");
    }
    update();
  }
}

///
/// old code
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:get/get.dart';
// import 'package:otpless_flutter/otpless_flutter.dart';
// import 'package:talkangels/api/repo/auth_repo.dart';
// import 'package:talkangels/ui/angels/constant/app_string.dart';
// import 'package:talkangels/models/response_item.dart';
// import 'package:talkangels/ui/angels/models/user_login_res_model.dart';
// import 'package:talkangels/models/whatsapp_login_res_model.dart';
// import 'package:talkangels/theme/app_layout.dart';
// import 'package:talkangels/ui/startup/referral_code_pages/referral_code_controller.dart';
// import 'package:talkangels/const/app_routes.dart';
// import 'package:talkangels/const/shared_prefs.dart';
//
// class LoginScreenController extends GetxController {
//   ReferralCodeController referralCodeController =
//       Get.put(ReferralCodeController());
//
//   final _otplessFlutterPlugin = Otpless();
//   String? phoneNumber;
//   String? code;
//   String? number;
//
//   /// WhatsApp Login
//   Future<void> isWhatsappInstalled() async {
//     _otplessFlutterPlugin.isWhatsAppInstalled().then(
//       (value) {
//         if (!value) {
//           showAppSnackBar(AppString.pleaseInstallTheWhatsapp);
//         }
//       },
//     );
//   }
//
//   // Future<void> startOtpless() async {
//   //   await _otplessFlutterPlugin.hideFabButton();
//   //   _otplessFlutterPlugin.openLoginPage((result) async {
//   //     try {
//   //       if (result['data'] != null) {
//   //         WhatsappLoginResponseModel resData =
//   //         WhatsappLoginResponseModel.fromJson(result['data']);
//   //         log("resData.mobile.number----------${resData.mobile!.number}");
//   //         log("resData.mobile.number----------${resData.waNumber}");
//   //         if(resData.waNumber!.length>=10){}else{}
//   //         var number=resData.waNumber!.length>=10? resData.waNumber!.replaceFirst('91', ""):resData.waNumber;
//   //         await signIn(
//   //             name: resData.waName ?? '',
//   //             // mNo: resData.waNumber!.replaceFirst('91', "") ,
//   //             mNo: number??"",
//   //             fcm: PreferenceManager().getFCMNotificationToken() ?? '');
//   //       }
//   //     } catch (e) {
//   //       log('----ERROR>>>$e');
//   //     }
//   //   });
//   // }
//   Future<void> startOtpless(String? referCode) async {
//     await _otplessFlutterPlugin.hideFabButton();
//
//     _otplessFlutterPlugin.openLoginPage((result) async {
//       try {
//         if (result['data'] != null) {
//           WhatsappLoginResponseModel resData =
//               WhatsappLoginResponseModel.fromJson(result['data']);
//           phoneNumber = result['data']["mobile"]["number"];
//           if (phoneNumber!.length > 10) {
//             code = phoneNumber!.substring(0, 2);
//             number = phoneNumber!.substring(2, phoneNumber!.length);
//           } else {
//             code = '';
//             number = phoneNumber;
//           }
//
//           /// API signIn
//           await signIn(
//               name: resData.waName ?? '',
//               mNo: number ?? '',
//               cCode: code ?? '',
//               fcm: PreferenceManager().getFCMNotificationToken() ?? '',
//               referCode: referCode);
//         }
//       } catch (e) {
//         log('----ERROR>>>$e');
//       }
//     });
//   }
//
//   /// API Calling
//
//   RxBool isLoading = false.obs;
//
//   Future<void> signIn(
//       {String? name,
//       String? mNo,
//       String? cCode,
//       String? fcm,
//       String? referCode}) async {
//     log("NAME  ${name}");
//     log("MOBILENO  ${mNo}");
//     log("COUNTRYCODE  ${cCode}");
//     log("FCMTOKEN  ${fcm}");
//
//     isLoading.value = true;
//     ResponseItem result = ResponseItem(message: AppString.somethingWentWrong);
//     result = await AuthRepo.userLogin(
//       name.toString(),
//       mNo.toString(),
//       cCode.toString(),
//       fcm.toString(),
//     );
//
//     try {
//       if (result.status) {
//         if (result.data != null) {
//           isLoading.value = false;
//           UserLoginResponseModel userRest =
//               UserLoginResponseModel.fromJson(result.data);
//
//           if (userRest.status == 200) {
//             PreferenceManager().setLogin(true);
//             PreferenceManager().setName(userRest.data?.name ?? '');
//             PreferenceManager()
//                 .setNumber(userRest.data?.mobileNumber.toString() ?? '');
//             PreferenceManager().setId(userRest.data?.id ?? '');
//             PreferenceManager().setToken(userRest.token ?? '');
//             PreferenceManager().setUserDetails(jsonEncode(userRest.data) ?? '');
//
//             showAppSnackBar(AppString.loginSuccessfully);
//             Get.offAllNamed(Routes.homeScreen);
//
//             if (referCode == '') {
//               /// homescreen
//               log("==1===homescreen===");
//             } else {
//               ///add referred
//               log("=2=referred====");
//               if (userRest.data?.status == 1) {
//                 ///login
//                 if (userRest.data?.referCodeStatus == 1) {
//                   ///already referred
//                   log("=3===already referred===");
//                 } else {
//                   ///aad referred
//                   log("=4===aad referred===");
//                 }
//               } else {
//                 /// register
//                 ///aad referred
//                 log("=5===aad referred===");
//               }
//             }
//
//             ///input refer
//             // referralCodeController.referralCodeApi(referCode!);
//
//             log("$result", name: "RESULT");
//             log("${result.data}", name: "RESULT_DATA");
//             log("$userRest", name: "RESULT11111");
//             log("${userRest.data}", name: "RESULT_DATA11111");
//
//             userRest.data;
//           } else {
//             log('${userRest.message}', name: "userRest.message");
//           }
//           update();
//         }
//       } else {
//         log("ERROR  2======>  ${result.message}");
//         showAppSnackBar(result.message!);
//         isLoading.value = false;
//       }
//     } catch (e) {
//       isLoading.value = false;
//       log("ERROR  1======>  $e");
//     }
//     update();
//   }
// }
