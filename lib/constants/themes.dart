
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';

abstract class Themes {
  static void statusIconsB() {
    if (GetPlatform.isAndroid) {
    } else if (GetPlatform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
  }
}