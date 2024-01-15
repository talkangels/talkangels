import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'bottom_bar_controller.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(Icons.account_balance_wallet),
                    label: "Call History"),
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