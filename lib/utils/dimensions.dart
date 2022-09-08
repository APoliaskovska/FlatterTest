import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // view
  static double pageViewContainer = screenHeight / 4.02;

  //padding
  static double heightPadding10 = screenHeight / 96.53;
  static double widthPadding10 = screenWidth / 48;
  static double widthPadding15 = screenWidth / 32;

  //radius

  static double radius20 = screenHeight/42.2;
  static double radius0 = screenHeight/28.13;

  // view size

  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height80 = screenHeight/10.55;

  static double height200 = screenHeight/4.8265;
  static double height280 = screenWidth/3.01;

  static double width200 = screenWidth/2;
  static double width150 = screenWidth/3.2;
  static double width50 = screenWidth/6.4;

  //font
  static double font14 = screenHeight / 60.33;
  static double font16 = screenHeight / 60.33125;
  static double font20 = screenHeight/42.2;

  //icon size
  static double iconSize24 = screenHeight / 40.22;
  static double iconSize16 = screenHeight / 60.33;
  static double iconSize50 = screenHeight / 19.309;
}