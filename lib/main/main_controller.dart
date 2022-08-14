import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sample/main/models/nav_data.dart';
import 'package:sample/routes/routes.dart';

import '../service/grpc/grpc_service.dart';

class MainController extends GetxController {
  final _navData = NavData();

//  List<NavBarItem> get menuData => _navData.menuData;
  List<NavItemData> get menuData {
    final output = List<NavItemData>.from(_navData.myData);
    // if (!SessionService.user.isSeller) {
    //   list.removeWhere((e) => e.route == Pages.SALE);
    // }
    return output;
  }

  int getNavItemIndexByNavKey(int navKey) {
    return menuData.indexWhere((e) => e?.navItem?.navKey == navKey);
  }

  final selectedNav = 0.obs;
  final _pages = <Widget>[];
  late NavItemData _currentModel;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => MainService());
    _currentModel = menuData.first;
  }

  List<Widget> getPages() {
//    _pages.clear();
    if (_pages.isEmpty) {
      _pages.addAll(menuData.map(
            (e) {
          if (e.navItem != null) {
            return Navigator(
              key: Get.nestedKey(e.navItem.navKey),
              onGenerateRoute: e.navItem.generateRoute,
            );
          } else {
            return Container();
          }
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
    if (model.navItem != null) {
      return Navigator(
        key: Get.nestedKey(model.navItem.navKey),
        initialRoute: '/',
        onGenerateRoute: model.navItem.generateRoute,
      );
    } else {
      return Container();
    }
  }

  Future<bool> canPop() async {
    return Future.value(false);
  }
}