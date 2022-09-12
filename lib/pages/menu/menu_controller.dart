import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/menu/settings/settings_controller.dart';
import 'package:sample/pages/menu/settings/settings_page.dart';
import 'package:sample/service/localization_service.dart';

import '../../widgets/main_app_bar.dart';

enum MenuItems {
  dashboard,
  messages,
  utilityBills,
  fundsTransfer,
  settings
}

extension ItemData on MenuItems {
  static List<MenuItems> allItems = [
    MenuItems.dashboard,
    MenuItems.messages,
    MenuItems.utilityBills,
    MenuItems.fundsTransfer,
    MenuItems.settings];

  String title() {
    switch (this) {
      case MenuItems.dashboard:
        return Strings.dashboard.translate();//LocalizationService.translator().dashboard;
      case MenuItems.messages:
        return Strings.messages.translate();
      case MenuItems.utilityBills:
        return Strings.utility_bills.translate();
      case MenuItems.fundsTransfer:
        return Strings.funds_transfer.translate();
      case MenuItems.settings:
        return Strings.settings.translate();
    }
  }
  IconData icon() {
    switch (this) {
      case MenuItems.dashboard:
        return Icons.dashboard;
      case MenuItems.messages:
        return Icons.message;
      case MenuItems.utilityBills:
        return Icons.document_scanner_outlined;
      case MenuItems.fundsTransfer:
        return Icons.currency_exchange;
      case MenuItems.settings:
        return Icons.settings;
    }
  }
}

class MenuController extends GetxController with GetSingleTickerProviderStateMixin {
  static MenuController get() => Get.find();

  MenuController();

  static MenuController? _this;
  static MenuController? get controller => _this;

  late AnimationController aController;
  late Animation<double> scaleAnimation;
  late Animation<double> menuScaleAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> avatarAnimation;

  final Duration duration = const Duration(milliseconds: 200);
  final _isCollapsed = true.obs;

  bool get isCollapsed => _isCollapsed();

  @override
  void onInit() {
    aController = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(aController);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(aController);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(aController);
    avatarAnimation =  Tween<double>(begin: 1.0, end: 0).animate(aController);

    super.onInit();
  }

  @override
  void dispose() {
    aController.dispose();
    super.dispose();
  }

  void setCollapsed(bool collapsed) {
    _isCollapsed(collapsed);
  }

  Future<void> didTapItem(MenuItems item) async {
    setCollapsed(!isCollapsed);

    Future.delayed(const Duration(milliseconds: 100), () async {
      await Get.to(
          SettingsPage(),
          transition: Transition.rightToLeft,
          binding: BindingsBuilder.put(() {
            return SettingsController();
          })
      );
    });
  }
}