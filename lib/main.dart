import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/pages/cards_page.dart';
import 'package:sample/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

