import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class MenuController extends GetxController with GetSingleTickerProviderStateMixin {
  static MenuController get() => Get.find();

  MenuController();

  static MenuController? _this;
  static MenuController? get controller => _this;

  late AnimationController aController;
  late Animation<double> scaleAnimation;
  late Animation<double> menuScaleAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> avatarAnimation;

  final Duration duration = const Duration(milliseconds: 200);
  final _isCollapsed = true.obs;

  bool get isCollapsed => _isCollapsed();

  @override
  void onInit() {
    aController = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(aController);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(aController);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(aController);
    avatarAnimation =  Tween<double>(begin: 1.0, end: 0).animate(aController);

    super.onInit();
  }

  @override
  void dispose() {
    aController.dispose();
    super.dispose();
  }

  void setCollapsed(bool collapsed) {
    _isCollapsed(collapsed);
  }
}