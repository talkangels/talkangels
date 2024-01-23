import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/ui/angels/main/drawer_pages/my_wallet_pages/my_wallet_screen_controller.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/angels/widgets/app_app_bar.dart';
import 'package:talkangels/ui/angels/widgets/app_button.dart';
import 'package:talkangels/ui/angels/widgets/app_dialogbox.dart';
import 'package:talkangels/ui/angels/widgets/app_textfield.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  MyWalletScreenController myWalletScreenController =
      Get.put(MyWalletScreenController());
  TextEditingController textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var walletBallance = Get.arguments["walletBallance"] ?? '';

  Razorpay razorpay = Razorpay();
  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
    textFieldController;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.myWallet,
        action: [
          const Icon(Icons.help_outline),
          (w * 0.045).addWSpace(),
        ],
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  (h * 0.02).addHSpace(),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppString.exploreTheFeaturesOfTALKANGELWallet
                              .regularLeagueSpartan(
                                  fontColor: yellowColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                          (h * 0.01).addHSpace(),
                          Row(
                            children: [
                              SizedBox(
                                  height: w * 0.3,
                                  width: w * 0.3,
                                  child: assetImage(
                                      AppAssets.walletAnimationAssets,
                                      fit: BoxFit.cover)),
                              (w * 0.04).addWSpace(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.verified,
                                          color: whiteColor, size: 18),
                                      (w * 0.02).addWSpace(),
                                      AppString.safetyOfPaymentTransfer
                                          .regularLeagueSpartan(fontSize: 12)
                                    ],
                                  ),
                                  (h * 0.01).addHSpace(),
                                  Row(
                                    children: [
                                      const Icon(Icons.verified,
                                          color: whiteColor, size: 18),
                                      (w * 0.02).addWSpace(),
                                      AppString.payInJustOneClick
                                          .regularLeagueSpartan(fontSize: 12)
                                    ],
                                  ),
                                  (h * 0.01).addHSpace(),
                                  Row(
                                    children: [
                                      const Icon(Icons.verified,
                                          color: whiteColor, size: 18),
                                      (w * 0.02).addWSpace(),
                                      AppString.payInJustOneClick
                                          .regularLeagueSpartan(fontSize: 12)
                                    ],
                                  ),
                                  (h * 0.01).addHSpace(),
                                  AppButton(
                                    height: 35,
                                    width: 135,
                                    onTap: () {},
                                    color: redFontColor,
                                    child: AppString.getStartedNow
                                        .regularLeagueSpartan(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  (h * 0.02).addHSpace(),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                        padding: EdgeInsets.all(w * 0.04),
                        child: Row(
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined,
                                color: whiteColor, size: 20),
                            (w * 0.02).addWSpace(),
                            AppString.talkAngelWalletBallance
                                .regularLeagueSpartan(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                            const Spacer(),
                            "$walletBallance".regularLeagueSpartan(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontColor: appColorGreen),
                          ],
                        )),
                  ),
                  (h * 0.02).addHSpace(),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.04),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.add_card,
                                    color: whiteColor, size: 20),
                                (w * 0.02).addWSpace(),
                                AppString.addMoneyTo.regularLeagueSpartan(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                AppString.talkAngelWallet.regularLeagueSpartan(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontColor: appColorGreen),
                              ],
                            ),
                            (h * 0.01).addHSpace(),
                            UnderLineTextFormField(
                              controller: textFieldController,
                              labelText: AppString.enterAmount,
                              height: 55,
                              keyboardType: TextInputType.number,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Please Enter Amount";
                                }
                                return null;
                              },
                            ),
                            (h * 0.04).addHSpace(),
                            AppButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  /// Payment Method

                                  var options = {
                                    'key': 'rzp_test_EM5urUrcGkdJvm',
                                    'amount': 100 *
                                        int.parse(textFieldController.text),
                                    'name': 'Acme Corp.',
                                    'description': 'Fine T-Shirt',
                                    'retry': {'enabled': true, 'max_count': 1},
                                    'send_sms_hash': true,
                                    'prefill': {
                                      'contact':
                                          "+91 ${PreferenceManager().getNumber().toString()}",
                                      'email': 'test@razorpay.com'
                                    },
                                    'external': {
                                      'wallets': ['paytm']
                                    }
                                  };
                                  try {
                                    razorpay.open(options);

                                    log("SUCCESS======>>>>>");
                                  } catch (e) {
                                    log("ERROR==RAZORPAY   $e");
                                  }
                                }
                              },
                              child: myWalletScreenController.isLoading == true
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: whiteColor))
                                  : AppString.proceed.regularLeagueSpartan(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  (h * 0.02).addHSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    log("${response.code}", name: "ERRORcode");
    log("${response.message}", name: "ERRORmessage");
    log("${response.error}", name: "ERRORerror");

    paymentFaildDialogBox(context,
        h: MediaQuery.of(context).size.height,
        w: MediaQuery.of(context).size.width,
        barrierDismissible: true,
        description: response.message);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    setState(() {
      walletBallance = walletBallance + int.parse(textFieldController.text);
    });

    ///API calling
    myWalletScreenController.addMyWalletAmountApi(
      textFieldController.text,
      response.paymentId.toString(),
    );

    log(response.data.toString(), name: "SUCCESS");

    paymentSuccessDialogBox(
      context,
      h: MediaQuery.of(context).size.height,
      w: MediaQuery.of(context).size.width,
      barrierDismissible: true,
    );
    setState(() {
      textFieldController.clear();
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(response.walletName.toString(), name: "EXTERNALWALLET");
    paymentFaildDialogBox(context,
        h: MediaQuery.of(context).size.height,
        w: MediaQuery.of(context).size.width,
        barrierDismissible: true,
        description: response.walletName);
  }
}

/// ON PAYMENT CANCELLED
var data = {
  "reason": "payment_cancelled",
  "metadata": {},
  "code": "BAD_REQUEST_ERROR",
  "contact": "+919510624635",
  "description":
      "You may have cancelled the payment or there was a delay in response from the UPI app",
  "step": "payment_authentication",
  "source": "customer",
  "email": "test@razorpay.com",
};
