import 'package:get/get.dart';
import 'package:sample/firebase_options.dart';

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
    return await authRepo.getToken().then((token) {
      if (token != null && token.isNotEmpty) {
        return Routes.MAIN;
      } else {
        return Routes.LOGIN;
      }
    });
  }

}