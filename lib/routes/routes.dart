import 'package:get/get.dart';
import 'package:sample/controllers/auth_controller.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/controllers/main_controller.dart';
import 'package:sample/controllers/profile_contoller.dart';
import 'package:sample/controllers/splash_controller.dart';
import 'package:sample/pages/main_page.dart';
import 'package:sample/pages/profile_page.dart';
import 'package:sample/pages/splash_screen.dart';
import '../pages/auth_page.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const SPLASH = '/splash';

  static const MAIN = '/main';
  static const PROFILE = '/profile';
  static const CARDS = '/cards';
}

abstract class AppPages {
  static String initial = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => AuthPage(),
      binding: BindingsBuilder.put(() => AuthController(authRepo: Get.find())),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      binding: BindingsBuilder.put(() => MainController()),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: BindingsBuilder.put(() => ProfileController(clientRepo: Get.find())),
    ),
    GetPage(
      name: Routes.CARDS,
      page: () => ProfilePage(),
      binding: BindingsBuilder.put(() => CardsController(cardsRepo: Get.find())),
    )
  ];
}