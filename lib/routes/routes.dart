import 'package:get/get.dart';
import 'package:sample/pages/menu/menu_controller.dart';
import 'package:sample/pages/menu/menu_page.dart';
import 'package:sample/service/repository/client_repo.dart';
import 'package:sample/splash/splash_controller.dart';
import 'package:sample/splash/splash_screen.dart';
import 'package:sample/service/repository/auth_repo.dart';
import 'package:sample/service/repository/cards_repo.dart';

import '../pages/auth/auth_controller.dart';
import '../pages/auth/auth_page.dart';
import '../pages/card_details/card_details_controller.dart';
import '../pages/card_details/card_details_page.dart';
import '../pages/card_details/cards_transactions/search_transaction_controller.dart';
import '../pages/card_details/cards_transactions/search_transaction_page.dart';
import '../pages/cards/cards_controller.dart';
import '../pages/main/main_controller.dart';
import '../pages/main/main_page.dart';
import '../pages/passcode/passcode_controller.dart';
import '../pages/passcode/passcode_page.dart';
import '../pages/profile/profile_contoller.dart';
import '../pages/profile/profile_page.dart';
import '../pages/top_up/top_up_controller.dart';
import '../pages/top_up/top_up_page.dart';
import '../service/grpc/grpc_service.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';

  static const PASSCODE = '/passcode';

  static const MAIN = '/';
  static const MENU = '/menu';
  static const PROFILE = '/profile';
  static const TOP_UP = '/top_up';
  static const CARDS = '/cards';
  static const UPLOAD = '/upload';

  static const CARDS_DETAILS = '/cards_details';

  static const SEARCH_TRANSACTION = '/search_transaction';
}

abstract class AppPages {
  static String initial = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => MainService());
        Get.lazyPut(() => AuthRepo());
        return SplashController(authRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => AuthPage(),
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => MainService());
        Get.lazyPut(() => AuthRepo());
        return AuthController(authRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      binding: BindingsBuilder.put(() => MainController()),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => ClientRepo());
        return ProfileController(clientRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.CARDS,
      page: () => ProfilePage(),
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => CardsRepo());
        return CardsController(cardsRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.CARDS_DETAILS,
      page: () => CardDetailsPage(),
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => CardsRepo());
        return CardDetailsController(cardsRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.SEARCH_TRANSACTION,
      page: () => SearchTransactionPage(),
      transition: Transition.circularReveal,
      binding: BindingsBuilder.put(() {
        Get.lazyPut(() => CardsRepo());
        return SearchTransactionController(cardsRepo: Get.find());
      }),
    ),
    GetPage(
      name: Routes.PASSCODE,
      page: () => PasscodePage(),
      transition: Transition.circularReveal,
      binding: BindingsBuilder.put(() {
        return PasscodeController();
      }),
    ),
    GetPage(
      name: Routes.TOP_UP,
      page: () => TopUpPage(),
      transition: Transition.circularReveal,
      binding: BindingsBuilder.put(() {
        return TopUpController();
      }),
    ),
    GetPage(
      name: Routes.MENU,
      page: () => MenuPage(),
      transition: Transition.circularReveal,
      binding: BindingsBuilder.put(() {
        return MenuController();
      })
    )
  ];
}