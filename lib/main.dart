import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/pages/splash_screen.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.AppDependencies.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CardsController>().getCardModelList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen()//title: 'Flutter Demo Home Page'),
    );
  }
}

