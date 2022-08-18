import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:sample/passcode/passcode_service.dart';
import 'package:sample/service/auth_service.dart';

import '../utils/get_utils.dart';

class PasscodeController extends GetxController with StateMixin {
  static PasscodeController get() => Get.find();

  final _title = "Enter passcode".obs;
  final int inputCount = 6;

  final LocalAuthentication auth = LocalAuthentication();
  final _passcodeString = "".obs;

  String get title => _title();
  String get passcodeString => _passcodeString();

  bool _isConfirmation = false;
  bool _isPasscodeExist = false;
  String _passcodeConfirm = "";
  String _passcode = "";

  PasscodeController();

  static PasscodeController? _this;
  static PasscodeController? get controller => _this;

  @override
  void onInit() async {
    super.onInit();

    _isPasscodeExist = await AuthService().isPasscodeExist();
    _title(_isPasscodeExist ? "Enter Passcode" : "Create Passcode");
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await Future.delayed(const Duration(seconds: 1));
    if (_isPasscodeExist == true) {
      await checkBiometrics();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isNumberEntered(int index) {
    int numberCount = passcodeString.length;
    return numberCount > index;
  }

  Future<void> didPassNumber(String index) async {
    if (_passcode.length + 1 == inputCount) {
      _passcode += index;
      _passcodeString(_passcode);

      if (_isPasscodeExist == true) {
        bool isValid = await AuthService().isPasscodeValid(_passcode);
        if (isValid) {
          _isConfirmation = false;
          PasscodeService().closePasscode();
        } else {
          _passcode = "";
          _passcodeString(_passcode);
          AppUtils.showError("Wrong passcode");
        }
      } else if (_isConfirmation == false) {
        _isConfirmation = true;
        _passcodeConfirm = _passcode;
        _passcode = "";
        _passcodeString(_passcode);
      } else {
        _isConfirmation = false;
        _isPasscodeExist = true;
        bool isValid = _passcodeConfirm == _passcode;
        if (isValid == false) { return; }
        await AuthService().setPasscode(_passcode);
        PasscodeService().closePasscode();
        _passcodeConfirm = "";
      }
    } else {
      _passcode += index;
      _passcodeString(_passcode);
    }
  }

  void deletePressed() {
    if (_passcode.length == 0) { return; }
    _passcode = _passcode.substring(0, _passcode.length - 1);
    _passcodeString(_passcode);
  }

  Future<void> checkBiometrics() async {
    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      return;
    }

    if (availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.face)) {
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            options: const AuthenticationOptions(biometricOnly: true));

        if (didAuthenticate == true){
          AuthService().isPasscodePass = true;
          PasscodeService().closePasscode();
        }
      } on PlatformException catch (e) {
        print("PlatformException " + e.toString());
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
        } else if (e.code == auth_error.notEnrolled) {
          AppUtils.showError("Biometric not enrolled");
        } else {
          // ...
        }
      }
    }
  }

}