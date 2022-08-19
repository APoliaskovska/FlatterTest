import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/passcode/passcode_controller.dart';
import 'package:sample/passcode/passcode_page.dart';
import 'dart:async';

import 'package:sample/service/auth_service.dart';

class PasscodeService extends GetxService {
  static final PasscodeService _instance = new PasscodeService._internal();
  PageRouteBuilder? _passcodeRoute;
  BuildContext? _passcodeContext;

  bool _isPasscodeShow = false;

  factory PasscodeService() {
    return _instance;
  }

  PasscodeService._internal();

  Future<void> showPasscodeIfNeeded() async {
    if (AuthService().isPasscodePass == true) { return; }
    if (_isPasscodeShow == true) {
      print("_isPasscodeShow == true");
      return;
    }

    _passcodeContext = Get.context;
    _passcodeRoute  = PageRouteBuilder(opaque: false, pageBuilder: (BuildContext context, _, __) {
      Get.lazyPut(() => PasscodeController());
      return PasscodePage();
      },
    );

    if (_passcodeContext == null) {
      print("_passcodeContext == null");
      return;
    }

    _isPasscodeShow = true;

    await Navigator.of(_passcodeContext!).push(_passcodeRoute!);
  }

  void closePasscode() {
    if (_passcodeContext == null || _passcodeRoute == null) {
      print("_passcodeContext == null");
      return;
    }
    _isPasscodeShow = false;
    Navigator.removeRoute(_passcodeContext!, _passcodeRoute!);
    _passcodeContext = null;
  }
}