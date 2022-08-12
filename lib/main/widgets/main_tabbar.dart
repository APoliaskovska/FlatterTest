import 'package:get/get.dart';
import 'package:sample/main/main_controller.dart';

abstract class MainTabController extends GetxController {
  final int? navId = null;
  bool _isTabOpen = false;

  MainController get rootController => Get.find();

  BaseTabController() {
    final myNavIndex = rootController.getNavItemIndexByNavKey(navId ?? 0);
    ever(rootController.selectedNav, (int value) {
      if (myNavIndex != null && myNavIndex == value) {
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