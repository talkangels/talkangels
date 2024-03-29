import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/main/home_pages/home_controller.dart';
import 'bottom_bar_controller.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with WidgetsBindingObserver {
  BottomBarController bottomBarController = Get.put(BottomBarController());
  HomeController homeController = Get.put(HomeController());

  bool isActive = true;

  @override
  void initState() {
    super.initState();

    /// ACTIVE STATUS API
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await homeController.activeStatusApi(AppString.online);
      await homeController.getStaffDetailApi();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        log('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        if (isActive == false) {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            await homeController.activeStatusApi(AppString.online);
          });
          setState(() {
            isActive = true;
          });
        }
        log('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        setState(() {
          isActive = false;
        });
        homeController.activeStatusApi(AppString.offline);
        log('appLifeCycleState paused');
        break;
      case AppLifecycleState.hidden:
        setState(() {
          isActive = false;
        });
        log('appLifeCycleState suspending');
        break;
      case AppLifecycleState.detached:
        setState(() {
          isActive = false;
        });
        log('appLifeCycleState detached');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("${PreferenceManager().getId()}", name: "USERID");
    log("${PreferenceManager().getToken()}", name: "TOKEN");
    log("${PreferenceManager().getLogin()}", name: "LOGIN");
    log(PreferenceManager().getName(), name: "NAME");
    log(PreferenceManager().getNumber(), name: "NUMBER");
    log(PreferenceManager().getFCMNotificationToken(),
        name: "FCMNOTIFICATIONTOKEN");
    log("${jsonDecode(PreferenceManager().getUserDetails())}",
        name: "DECODE====GETUSERDETAILS");

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.selectedPage != 0) {
              controller.selectedPage = 0;
              Get.toNamed(Routes.bottomBarScreen);
              controller.update();
              return false;
            }

            /// Active Status Api
            setState(() {
              isActive = false;
            });
            await homeController.activeStatusApi(AppString.offline);
            return true;
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: bottomBarbColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedPage,
              onTap: (value) {
                controller.setSelectedPage(value);
              },
              unselectedItemColor: bottomBarIconsColor,
              selectedItemColor: appColorBlue,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "Call History"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Setting"),
              ],
            ),
            body: Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(gradient: appGradient),
              child: SafeArea(
                child: controller.screens[controller.selectedPage],
              ),
            ),
          ),
        );
      },
    );
  }
}
