import 'package:get/get.dart';

import '../routes/routes.dart';
import '../service/repository/auth_repo.dart';

class SplashController extends GetxController {
  static SplashController get() => Get.find();

  final AuthRepo authRepo;
  SplashController({required this.authRepo});

  static SplashController? _this;
  static SplashController? get controller => _this;

  Future<String> checkNextRoute() async {
    await 1.delay();
    return await authRepo.getToken().then((token) {
      if (token != null && token.isNotEmpty) {
        return Routes.MAIN;
      } else {
        return Routes.LOGIN;
      }
    });
  }

}