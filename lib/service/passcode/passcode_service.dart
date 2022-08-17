import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'dart:async';

import 'package:sample/service/auth_service.dart';
import 'package:sample/widgets/small_text.dart';

class PasscodeService extends GetxService {
  static final PasscodeService _instance = new PasscodeService._internal();
  final StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();


  bool _isPasscodeShow = false;
  bool _isConfirmation = false;
  bool _isPasscodeExist = false;

  String _passcodeConfirm = "";

  factory PasscodeService() {
    return _instance;
  }

  PasscodeService._internal();

  Future<void> showPasscodeIfNeeded() async {
    if (AuthService().isPasscodePass == true) { return; }
    if (_isPasscodeShow == true) { return; }

    _isPasscodeShow = true;
    _isPasscodeExist = await AuthService().isPasscodeExist();

    String title = _isConfirmation ? "Confirm Passcode" : _isPasscodeExist ? "Enter Passcode" : "Create Passcode";
    Widget passcodeScreen = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: PasscodeScreen(
        title: SmallText(text: title, color: Colors.white, size: 16.0),
        passwordEnteredCallback: await _onPasscodeEntered,
        cancelButton: Text(''),
        deleteButton: Icon(Icons.backspace_outlined, color: Colors.white,),
        cancelCallback: _onPasscodeCancelled(),
        shouldTriggerVerification: _verificationNotifier.stream,
        backgroundColor: Colors.black.withOpacity(0.8),
        bottomWidget: _buildPasscodeRestoreButton(),
      ),
    );

    BuildContext? context = Get.context;
    if (context == null) { return; }

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return passcodeScreen;
        }
    ));
  }

  _onPasscodeEntered(String enteredPasscode) async {
    if (_isPasscodeExist == true) {
      bool isValid = await AuthService().isPasscodeValid(enteredPasscode);
      _verificationNotifier.add(isValid);
      if (isValid) {
        _isConfirmation = false;
        _isPasscodeShow = false;
        Get.delete();
      }
    } else if (_isConfirmation == false) {
      _isConfirmation = true;
      _isPasscodeShow = false;
      _passcodeConfirm = enteredPasscode;
      Get.delete();
      showPasscodeIfNeeded();
    } else {
      _isConfirmation = false;
      _isPasscodeExist = true;
      _isPasscodeShow = false;
      bool isValid = _passcodeConfirm == enteredPasscode;
      if (isValid == false) { return; }
      await AuthService().setPasscode(enteredPasscode);
      Get.delete();
      _passcodeConfirm = "";
    }
  }

  _onPasscodeCancelled() {
   // if (_passcodeScreen == null) { return; }
  }

  _buildPasscodeRestoreButton() => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
     // margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
      child: TextButton(
        child: SmallText(text:
          "Forgot passcode?",
          color: Colors.white,
          size: 14.0,
        ),
        onPressed: _resetAppPassword,
      ),
    ),
  );

  _resetAppPassword() {

  }
}