import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/main/call_history_pages/call_history_controller.dart';
import 'package:talkangels/ui/staff/models/get_call_history_res_model.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_show_profile_pic.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  CallHistoryController callHistoryController =
      Get.put(CallHistoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callHistoryController.getCallHistoryApi();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.callHistory,
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: GetBuilder<CallHistoryController>(
        builder: (controller) {
          List<CallHistory>? reverseData =
              controller.getCallHistoryResModel.data?.reversed.toList();
          return Container(
            height: h,
            width: w,
            decoration: const BoxDecoration(gradient: appGradient),
            child: SafeArea(
              child: controller.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.getCallHistoryResModel.data!.isEmpty
                      ? Center(
                          child: AppString.noDataFound.regularLeagueSpartan(
                              fontColor: greyFontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: reverseData!.length,
                          itemBuilder: (context, index) {
                            int lastIndex =
                                reverseData[index].history!.length - 1;

                            DateTime myDateTime = DateTime.parse(
                                "${reverseData[index].history?[lastIndex].date}");

                            String formattedDate =
                                DateFormat('MMM d').format(myDateTime);
                            String formattedTime =
                                DateFormat('hh:mm a').format(myDateTime);

                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.moreCallInfoScreen,
                                    arguments: {
                                      "call_history": reverseData[index]
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.05, vertical: h * 0.015),
                                child: Row(
                                  children: [
                                    AppShowProfilePic(
                                        onTap: () {},
                                        image: reverseData[index].user?.image ??
                                            "",
                                        borderShow: false),
                                    (w * 0.02).addWSpace(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            (reverseData[index]
                                                        .user
                                                        ?.userName ??
                                                    '')
                                                .regularLeagueSpartan(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            (w * 0.02).addWSpace(),
                                            reverseData[index]
                                                        .history?[lastIndex]
                                                        .callType ==
                                                    "outgoing"
                                                ? const CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        appColorBlue,
                                                    child: Icon(
                                                      Icons.phone_forwarded,
                                                      size: 10,
                                                      color: whiteColor,
                                                    ),
                                                  )
                                                : reverseData[index]
                                                            .history?[lastIndex]
                                                            .callType ==
                                                        "incoming"
                                                    ? const CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            appColorGreen,
                                                        child: Icon(
                                                          Icons.phone_callback,
                                                          size: 10,
                                                          color: whiteColor,
                                                        ),
                                                      )
                                                    : const CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            redColor,
                                                        child: Icon(
                                                          Icons.phone_missed,
                                                          size: 10,
                                                          color: whiteColor,
                                                        ),
                                                      ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: w * 0.65,
                                          child:
                                              "${reverseData[index].user?.mobileNumber ?? ''} • $formattedDate •${reverseData[index].history?[lastIndex].callType} call at $formattedTime"
                                                  .regularLeagueSpartan(
                                                      fontColor: greyFontColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      textOverflow: TextOverflow
                                                          .ellipsis),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: whiteColor.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 1.0.appDivider();
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}
