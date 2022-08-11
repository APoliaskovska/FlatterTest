import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get() => Get.find();

  static MainController? _this;
  static MainController? get controller => _this;

  MainController();
}