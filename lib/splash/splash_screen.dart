import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/splash/splash_controller.dart';

import '../utils/dimensions.dart';

class SplashScreen extends StatelessWidget  {

  SplashController controller = Get.put(SplashController(authRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
        duration: 1000,
        backgroundColor: Colors.white,
        splash: Image.asset("assets/images/splash_bg.jpg"),
        splashIconSize: Dimensions.screenWidth * 0.8,
        splashTransition: SplashTransition.fadeTransition,
        screenRouteFunction: () async {
          return await controller.checkNextRoute();//Future(() => controller.nextRoute);
        });
  }
}
