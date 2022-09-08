import 'package:get/get.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/service/auth_service.dart';

import '../routes/routes.dart';
import '../service/repository/auth_repo.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashController extends GetxController {
  static SplashController get() => Get.find();

  final AuthRepo authRepo;
  SplashController({required this.authRepo});

  static SplashController? _this;
  static SplashController? get controller => _this;

  Future<String> checkNextRoute() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (error) {
      print("Firebase error: " + error.toString());
    }
    return await AuthService().getToken().then((token) async {
      if (token != null && token.isNotEmpty) {
        return Routes.MENU;
      } else {
        bool isFirstLoad = await AuthService().getFirstLoad();
        return isFirstLoad == true ? Routes.ONBOARDING : Routes.LOGIN;
      }
    });
  }

}