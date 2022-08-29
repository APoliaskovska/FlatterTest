import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/service/auth_service.dart';

import '../../service/grpc/grpc_service.dart';
import '../passcode/passcode_service.dart';
import 'models/nav_data.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  final _navData = NavData();

  List<NavItemData> get menuData {
    final output = List<NavItemData>.from(_navData.myData);
    return output;
  }

  int getNavItemIndexByNavKey(int navKey) {
    return menuData.indexWhere((e) => e.navItem.navKey == navKey);
  }

  final selectedNav = 0.obs;
  final _pages = <Widget>[];
  late NavItemData _currentModel;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => MainService());
    _currentModel = menuData.first;
    WidgetsBinding.instance.addObserver(this);
  }

  List<Widget> getPages() {
//    _pages.clear();
    if (_pages.isEmpty) {
      _pages.addAll(menuData.map(
            (e) {
              return Navigator(
                key: Get.nestedKey(e.navItem.navKey),
                onGenerateRoute: e.navItem.generateRoute,
              );
        },
      ));
    }
    return _pages;
  }

  Future<void> onTapNav(int idx) async {
    /// only for VENTA we make a special case...
    final model = menuData[idx];
    // if (model.route == Routes.PROFILE) {
    //   Get.toNamed(Routes.PROFILE);
    // } else {
      if (model != _currentModel) {
        _currentModel = model;

      } else {
        final navKey = Get.nestedKey(_currentModel.navItem.navKey);
        if (navKey != null && navKey.currentState != null && navKey.currentState!.canPop()) {
//          navKey.currentState.pop();
          await canPop();
        }
      }
      selectedNav(idx);
    //}
  }

  Widget getPage() {
    final model = menuData[selectedNav()];
    return Navigator(
      key: Get.nestedKey(model.navItem.navKey),
      initialRoute: '/',
      onGenerateRoute: model.navItem.generateRoute,
    );
  }

  Future<bool> canPop() async {
    return Future.value(false);
  }

  Future<void> _showPasscode() async {
    final pService = PasscodeService();
    await pService.showPasscodeIfNeeded();
  }

  @override
  void onReady() async {
    super.onReady();
    await _showPasscode();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      await _showPasscode();
    } else  if (state == AppLifecycleState.paused) {
      AuthService().isPasscodePass = false;
      AuthService().setBackgroundTime(DateTime.now());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}