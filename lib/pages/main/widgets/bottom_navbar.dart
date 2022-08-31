import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/utils/dimensions.dart';

import '../main_controller.dart';

class BottomNavBar extends GetView<MainController> {

  @override
  Widget build(BuildContext context) {
    final items = controller.menuData
        .map((e) => _navigationBarItem(e.icon, e.name))//BottomNavigationBarItem(icon: Icon(e.icon), label: e.name))
        .toList();
    return Obx(
          () => BottomNavigationBar(
            key: AppGlobalKeys.bottomNavBar,
            items: items,
            elevation: 8,
            iconSize: Dimensions.iconSize16*2,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
            unselectedIconTheme: IconThemeData(color: AppColors.mediumGrayColor),
            onTap: (idx) => controller.onTapNav(idx),
            currentIndex: controller.selectedNav(),
      ),
    );
  }

  BottomNavigationBarItem _navigationBarItem(IconData icon, String name) {
    return BottomNavigationBarItem(
      icon: name != 'upload' ? Icon(icon) : Container(
        height: Dimensions.iconSize16*2,
        width: Dimensions.iconSize16*2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.iconSize16)),
        ),
        child: Positioned(
          top: 10.0,
          child:  Icon(icon),
        ),
      ) ,
      label: name
    );
  }

  /*
   Image.asset(
        index == 0
            ? "assets/homeScreenImages/appointment_active.png"
            : "assets/homeScreenImages/appointment_unactive.png",
        height: 25,
        width: 25,
        fit: BoxFit.cover,
      )
   */
}
