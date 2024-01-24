import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/main/report_problem_pages/report_problem_screen_controller.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/widgets/app_button.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  ReportProblemScreenController reportProblemScreenController =
      Get.put(ReportProblemScreenController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.reportAProblem,
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: GetBuilder<ReportProblemScreenController>(
        builder: (controller) {
          return Container(
            height: h,
            width: w,
            decoration: const BoxDecoration(gradient: appGradient),
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    (h * 0.05).addHSpace(),
                    TextFormField(
                      maxLines: 10,
                      minLines: 10,
                      onChanged: (value) {},
                      controller: controller.textFieldController,
                      style: const TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'League Spartan'),
                      decoration: InputDecoration(
                        hintText: "Comments",
                        hintStyle: const TextStyle(
                            color: greyFontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'League Spartan'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: appBarColor),
                        ),
                      ),
                      validator: (value) {
                        if (controller.textFieldController.text.isEmpty) {
                          return AppString.pleaseEnterYourProblem;
                        }
                        return null;
                      },
                    ),
                    (h * 0.1).addHSpace(),
                    AppButton(
                      color: appColorBlue,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          ///  Post Report A Problem Api _STAFF
                          controller.sendReportAProblem(
                              controller.textFieldController.toString());
                          Get.back();
                        }
                      },
                      child: controller.isLoading == true
                          ? const Center(
                              child:
                                  CircularProgressIndicator(color: whiteColor))
                          : AppString.submit.regularLeagueSpartan(
                              fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
