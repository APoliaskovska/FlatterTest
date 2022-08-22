import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/cards/cards_controller.dart';
import 'package:sample/cards/cards_page.dart';
import 'package:sample/profile/profile_contoller.dart';
import 'package:sample/profile/profile_page.dart';
import 'package:sample/routes/routes.dart';
import 'package:sample/service/repository/cards_repo.dart';
import 'package:sample/service/repository/client_repo.dart';
import 'package:sample/top_up/top_up_controller.dart';
import 'package:sample/top_up/top_up_page.dart';

abstract class NavKeys {
  static const int CARDS = 0;
  static const int TOP_UP = 1;
  static const int PROFILE = 2;
}

class NavItem {
  final int navKey;
  final GetPage getPage;
  NavItem({required this.navKey, required this.getPage});
  PageRoute generateRoute(RouteSettings settings) {
    return GetPageRoute(
      page: getPage.page,
      routeName: getPage.name,
      binding: getPage.binding,
    );
  }
}

class NavItemData {
  final String name;
  final IconData icon;
  final String route; // Routes.SOMETHING
  final NavItem navItem;
  NavItemData({required this.name,
    required this.icon,
    required this.navItem,
    required this.route});
}

class NavData {
  final List<NavItemData> myData = [
    NavItemData(
      name: 'cards',
      route: Routes.CARDS,
      icon: Icons.credit_card,
      navItem: NavItem(
        navKey: NavKeys.CARDS,
        getPage: GetPage(
          name: Routes.CARDS,
          page: () => CardsPage(),
          binding: BindingsBuilder.put(() {
            Get.lazyPut(() => CardsRepo());
            return CardsController(cardsRepo: Get.find());
          }),
        ),
      ),
    ),
    NavItemData(
      name: 'top_up',
      route: Routes.TOP_UP,
      icon: Icons.add_card,
      navItem: NavItem(
        navKey: NavKeys.TOP_UP,
        getPage: GetPage(
          name: Routes.TOP_UP,
          page: () => TopUpPage(),
          binding: BindingsBuilder.put(() => TopUpController()
          ),
        ),
      ),
    ),
    NavItemData(
      name: 'profile',
      route: Routes.PROFILE,
      icon: Icons.person,
      navItem: NavItem(
        navKey: NavKeys.PROFILE,
        getPage: GetPage(
          name: Routes.PROFILE,
          page: () => ProfilePage(),
          binding: BindingsBuilder.put(() {
            Get.lazyPut(() => ClientRepo());
            return ProfileController(clientRepo: Get.find());
          }),
        ),
      ),
    ),
  ];
}