import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';

// showAppSnackBar(
//   String tittle,
// ) {
//   return Get.showSnackbar(
//     GetSnackBar(
//       messageText: Text(
//         tittle,
//         style: const TextStyle(color: Colors.white),
//       ),
//       borderRadius: 0,
//       snackPosition: SnackPosition.TOP,
//       margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//       shouldIconPulse: false,
//       icon: Container(
//         height: 25,
//         width: 25,
//         decoration:
//             const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//         child: const Center(
//           child: Icon(
//             Icons.close_rounded,
//             color: whiteColor,
//           ),
//         ),
//       ),
//       backgroundColor: textFieldBorderColor,
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }

showAppSnackBar(
  String tittle,
) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(tittle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: whiteColor)),
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      shouldIconPulse: false,
      backgroundColor: greyFontColor,
      duration: const Duration(seconds: 3),
    ),
  );
}
