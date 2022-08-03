import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sample/pages/main_page.dart';
import '../utils/dimensions.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 2000,
        backgroundColor: Colors.white,
        splash: Image.asset("assets/images/splash_bg.jpg"),
        splashIconSize: Dimensions.screenWidth * 0.8,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: const MainPage());
  }
}
