import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/pages/files/files/files_controller.dart';
import 'package:sample/pages/files/files/files_page.dart';
import 'package:sample/pages/files/folders/folders_controller.dart';
import 'package:sample/pages/files/folders/folders_page.dart';
import 'package:sample/pages/upload/upload_controller.dart';
import 'package:sample/pages/upload/upload_page.dart';
import 'package:sample/routes/routes.dart';
import 'package:sample/service/repository/cards_repo.dart';
import 'package:sample/service/repository/client_repo.dart';
import 'package:sample/service/repository/upload_repo.dart';

import '../../cards/cards_controller.dart';
import '../../cards/cards_page.dart';
import '../../profile/profile_contoller.dart';
import '../../profile/profile_page.dart';
import '../../top_up/top_up_controller.dart';
import '../../top_up/top_up_page.dart';

abstract class NavKeys {
  static const int CARDS = 0;
  static const int TOP_UP = 1;
  static const int UPLOAD = 2;
  static const int FOLDERS = 3;
  static const int PROFILE = 4;
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
      name: 'upload',
      route: Routes.UPLOAD,
      icon: Icons.upload,
      navItem: NavItem(
        navKey: NavKeys.UPLOAD,
        getPage: GetPage(
          name: Routes.UPLOAD,
          page: () => UploadPage(),
          binding: BindingsBuilder.put(() {
            Get.lazyPut(() => UploadRepo());
            return UploadController(uploadRepo: Get.find());
          }
          ),
        ),
      ),
    ),
    NavItemData(
      name: 'folders',
      route: Routes.FOLDERS,
      icon: Icons.folder_copy_outlined,
      navItem: NavItem(
        navKey: NavKeys.FOLDERS,
        getPage: GetPage(
          name: Routes.FOLDERS,
          page: () => FoldersPage(),
          binding: BindingsBuilder.put(() {
            Get.lazyPut(() => UploadRepo());
            return FoldersController(uploadRepo: Get.find());
          }
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