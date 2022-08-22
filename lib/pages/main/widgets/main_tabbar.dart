import 'package:get/get.dart';

import '../main_controller.dart';

abstract class MainTabController extends GetxController {
  final int? navId = null;
  bool _isTabOpen = false;

  MainController get rootController => Get.find();

  MainTabController() {
    final myNavIndex = rootController.getNavItemIndexByNavKey(navId ?? 0);
    ever(rootController.selectedNav, (int value) {
      print("selectedNav = " + value.toString());
      if (myNavIndex == value) {
        _isTabOpen = true;
        onTabOpen();
      } else {
        if (_isTabOpen) {
          _isTabOpen = false;
          onTabClose();
        }
      }
    });
  }
  void onTabOpen() {}
  void onTabClose() {}
}