import 'package:get/get.dart';

import '../routes/routes.dart';

class SplashController extends GetxController {
  // ApiService get api => ApiService.get();

  @override
  void onReady() {
    super.onReady();
    _initState();
  }

  Future<void> _initState() async {
    await 1.delay();
    // final hasToken = api.auth.hasToken;
    // final user = SessionService.user;
    bool hasToken = false;
    if (!hasToken) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.MAIN);
    }
  }
}