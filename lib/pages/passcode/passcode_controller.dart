import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/passcode/passcode_service.dart';

import 'package:sample/service/auth_service.dart';

import '../../utils/get_utils.dart';


class PasscodeController extends GetxController with StateMixin {
  static PasscodeController get() => Get.find();

  final _title = "".obs;
  final int inputCount = 6;

  final LocalAuthentication auth = LocalAuthentication();
  final _passcodeString = "".obs;
  final _isPasscodeExist = false.obs;
  final _showAnimation = false.obs;

  String get title => _title();
  String get passcodeString => _passcodeString();
  bool get isPasscodeExist => _isPasscodeExist();
  bool get showAnimation => _showAnimation();

  bool _isConfirmation = false;
  String _passcodeConfirm = "";
  String _passcode = "";

  PasscodeController();

  static PasscodeController? _this;
  static PasscodeController? get controller => _this;

  @override
  void onInit() async {
    super.onInit();

    _isPasscodeExist(await AuthService().isPasscodeExist());
    _title(isPasscodeExist ? Strings.enter_passcode.translate() : Strings.create_passcode.translate());
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    if (isPasscodeExist == true) {
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

      if (isPasscodeExist == true) {
        bool isValid = await AuthService().isPasscodeValid(_passcode);
        if (isValid) {
          _isConfirmation = false;
          _close();
        } else {
          _showAnimation(true);
         // AppUtils.showError("Wrong passcode");
        }
      } else if (_isConfirmation == false) {
        _title(Strings.confirm_passcode.translate());
        _isConfirmation = true;
        _passcodeConfirm = _passcode;
        _passcode = "";
        _passcodeString(_passcode);
      } else {
        _isConfirmation = false;
        _isPasscodeExist(true);

        bool isValid = _passcodeConfirm == _passcode;
        if (isValid == false) { return; }
        await AuthService().setPasscode(_passcode);
        _close();
        _title(Strings.enter_passcode.translate());
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

  void onAnimationEnd(){
    _showAnimation(false);
    _passcode = "";
    _passcodeString(_passcode);
  }

  void _close() {
    _passcode = "";
    _passcodeConfirm = "";
    _passcodeString(_passcode);
    AuthService().isPasscodePass = true;
    PasscodeService().closePasscode();
  }

  Future<void> checkBiometrics() async {
    if (await _isDeviceSupported() == false) { return; }
    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();
    print("checkBiometrics tapped: " + availableBiometrics.toString());

    if (availableBiometrics.isEmpty) {
      print("availableBiometrics isEmpty");
      return;
    }

    if (availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.face)) {
      print("availableBiometrics face || fingerprint");
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            options: const AuthenticationOptions(biometricOnly: true),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Oops! Biometric authentication required!',
              cancelButton: 'No thanks',),
            IOSAuthMessages(
              cancelButton: 'No thanks',
            )]
        );

        if (didAuthenticate == true){
          _close();
        }
      } on PlatformException catch (e) {
        print("PlatformException " + e.toString());
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
        } else if (e.code == auth_error.notEnrolled) {
          AppUtils.showError(Strings.biometric_error.translate());
        } else {
          // ...
        }
      }
    }
  }

  Future<bool> _isDeviceSupported() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }
}