import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/widgets/preloader.dart';

class AppUtils {
  static bool isPreloading = false;
  static bool get isSnackbarOpened => _oldSnackStatus != SnackbarStatus.OPEN;
  static SnackbarStatus? _oldSnackStatus;

  static Future<void> showPreloader() async {
    if (isPreloading) return;
    isPreloading = true;
    Get.dialog(
      Center(child: PreloaderCircular()),
      barrierDismissible: false,
    );
  }

  static Future<void> hidePreloader() async {
    if (!isPreloading) return;
    isPreloading = false;
    if (!Get.isSnackbarOpen) {
      Get.back();
    }
  }

  static void showError(String errors, {
    String title = 'Error:',
    SnackbarStatusCallback? onStatus,
  }) {
    bool isDialogOpen = Get.isDialogOpen ?? false;
    if (isPreloading && isDialogOpen) {
      hidePreloader();
    }

    Get.snackbar(
      title,
      errors,
      colorText: Colors.white,
      borderRadius: 0,
      snackbarStatus: (status) {
        _oldSnackStatus = status;
        onStatus?.call(status);
      },
      backgroundColor: Colors.red.shade800,
      icon: Icon(Icons.error, color: Colors.white),
      animationDuration: 0.45.seconds,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.easeOutExpo,
      overlayColor: Colors.white54,
      overlayBlur: .1,
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}