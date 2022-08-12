import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/main/main_controller.dart';

class BottomNavBar extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    final items = controller.menuData
        .map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.name))
        .toList();
    return Obx(
          () => BottomNavigationBar(
        items: items,
        elevation: 8,
        iconSize: 18,
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
}
