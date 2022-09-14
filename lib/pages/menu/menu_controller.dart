import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/menu/contacts_us/contact_us_controller.dart';
import 'package:sample/pages/menu/contacts_us/contact_us_page.dart';
import 'package:sample/pages/menu/settings/settings_controller.dart';
import 'package:sample/pages/menu/settings/settings_page.dart';

enum MenuItems {
  dashboard,
  messages,
  utilityBills,
  fundsTransfer,
  settings,
  contact_us,
  notifications
}

extension ItemData on MenuItems {
  static List<MenuItems> allItems = [
    MenuItems.dashboard,
    MenuItems.messages,
    MenuItems.notifications,
    MenuItems.fundsTransfer,
    MenuItems.settings,
    MenuItems.contact_us];

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
      case MenuItems.contact_us:
        return Strings.contact_us_title.translate();
      case MenuItems.notifications:
        return Strings.notifications_title.translate();
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
      case MenuItems.contact_us:
        return Icons.message_outlined;
      case MenuItems.notifications:
        return Icons.notifications;
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
      if (item == MenuItems.settings) {
        await _goToSettings();
      } else {
        await _goToContactUs();
      }
    });
  }

    Future<dynamic> _goToContactUs() async {
      await Get.to(
          ContactUsPage(),
          transition: Transition.rightToLeft,
          binding: BindingsBuilder.put(() {
            return ContactUsController();
          })
      );
    }

    Future<dynamic> _goToSettings() async {
      await Get.to(
          SettingsPage(),
          transition: Transition.rightToLeft,
          binding: BindingsBuilder.put(() {
            return SettingsController();
          })
      );
    }

  Future<dynamic> _goToNotifications() async {
    await Get.to(
        SettingsPage(),
        transition: Transition.rightToLeft,
        binding: BindingsBuilder.put(() {
          return SettingsController();
        })
    );
  }
}