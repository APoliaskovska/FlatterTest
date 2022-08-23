import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/splash/splash_controller.dart';

import '../utils/dimensions.dart';

class SplashScreen extends StatelessWidget  {
  final SplashController controller = Get.put(SplashController(authRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
      duration: 1600,
      backgroundColor: AppColors.navBgColor,
      splash: Image.asset("assets/images/logo.png", color: AppColors.primaryColor),
      splashIconSize: Dimensions.screenWidth * 0.6,
      splashTransition: SplashTransition.rotationTransition,
      curve: Curves.easeInOut,
      screenRouteFunction: () async {
          return await controller.checkNextRoute();//Future(() => controller.nextRoute);
        });
  }
}
