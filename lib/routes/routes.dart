import 'package:get/get.dart';
import 'package:sample/auth/auth_controller.dart';
import 'package:sample/auth/auth_page.dart';
import 'package:sample/card_details/card_details_controller.dart';
import 'package:sample/card_details/cards_transactions/search_transaction_controller.dart';
import 'package:sample/card_details/cards_transactions/search_transaction_page.dart';
import 'package:sample/cards/cards_controller.dart';
import 'package:sample/service/repository/client_repo.dart';
import 'package:sample/splash/splash_controller.dart';
import 'package:sample/card_details/card_details_page.dart';
import 'package:sample/profile/profile_page.dart';
import 'package:sample/splash/splash_screen.dart';
import 'package:sample/service/repository/auth_repo.dart';
import 'package:sample/service/repository/cards_repo.dart';

import '../main/main_controller.dart';
import '../main/main_page.dart';
import '../profile/profile_contoller.dart';
import '../service/grpc/grpc_service.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';

  static const MAIN = '/';
  static const PROFILE = '/profile';
  static const CARDS = '/cards';
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
    )
  ];
}