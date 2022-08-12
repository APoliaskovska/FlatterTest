import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SPLASH!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedSplashScreen(
  //       duration: 1000,
  //       backgroundColor: Colors.white,
  //       splash: Image.asset("assets/images/splash_bg.jpg"),
  //       splashIconSize: Dimensions.screenWidth * 0.8,
  //       splashTransition: SplashTransition.fadeTransition,
  //       pageTransitionType: PageTransitionType.fade,
  //       nextScreen: AuthPage());
  // }
}
