import 'package:get/get.dart';
import 'package:sample/controllers/auth_controller.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/controllers/profile_contoller.dart';
import 'package:sample/grpc/grpc_service.dart';
import 'package:sample/service/repository/auth_repo.dart';
import 'package:sample/service/repository/cards_repo.dart';
import 'package:sample/service/repository/client_repo.dart';

class AppDependencies {
  static Future<void> init() async {
    Get.lazyPut(() => MainService());

    Get.lazyPut(() => CardsRepo());
    Get.lazyPut(() => AuthRepo());
    Get.lazyPut(() => ClientRepo());

    Get.lazyPut(() => CardsController(cardsRepo: Get.find()));
    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => ProfileController(clientRepo: Get.find()));
  }
}
