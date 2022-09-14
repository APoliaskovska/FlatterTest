import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/service/auth_service.dart';
import '../../../service/localization_service.dart';

enum SettingsItems {
  language
}

extension SettingsData on SettingsItems {
  static List<SettingsItems> allItems = [SettingsItems.language];

  String title() {
    switch (this) {
      case SettingsItems.language:
        return "Language";
    }
  }

  String accessoryText() {
    switch (this) {
      case SettingsItems.language:
        return LocalizationService().getLocaleLanguage().langName;
    }
  }

  IconData icon() {
    switch (this) {
      case SettingsItems.language:
        return Icons.language;
    }
  }

}

class SettingsController extends GetxController {
  static SettingsController get() => Get.find();

  SettingsController();

  List<Language> appLanguages = Language.languageList;

  final _currentLanguage = Language.languageList.first.obs;
  final _passcodeEnabled = true.obs;
  final _faceIdEnabled = true.obs;

  Language get currentLanguage => _currentLanguage();
  bool get passcodeEnabled => _passcodeEnabled();
  bool get faceIdEnabled => _faceIdEnabled();

  //public

  @override
  Future<void> onInit() async {
    super.onInit();
    _updateCurrentLanguage();

    _passcodeEnabled(await AuthService().getPasscodeEnabled());
    _faceIdEnabled(await AuthService().getFaceIdEnabled());
  }

  void didChangeLanguage(Language language) async {
    await LocalizationService().changeLanguage(language);
    _currentLanguage(language);
  }

  void _updateCurrentLanguage() {
    _currentLanguage(LocalizationService().getLocaleLanguage());
  }

  Future<void> setEnablePasscode(bool enabled) async {
    await AuthService().setPasscodeEnabled(enabled);
    _passcodeEnabled(enabled);
    if (enabled == false) {
      await setEnableFaceId(enabled);
    }
  }

  Future<void> setEnableFaceId(bool enabled) async {
    if (passcodeEnabled == false && enabled == true) { return; }
    await AuthService().setFaceIdEnabled(enabled);
    _faceIdEnabled(enabled);
  }
}