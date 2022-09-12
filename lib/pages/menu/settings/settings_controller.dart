import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Language get currentLanguage => _currentLanguage();

  //public

  @override
  void onInit() {
    super.onInit();
    _updateCurrentLanguage();
  }

  void didChangeLanguage(Language language) async {
    await LocalizationService().changeLanguage(language);
    _currentLanguage(language);
  }

  void _updateCurrentLanguage() {
    _currentLanguage(LocalizationService().getLocaleLanguage());
  }

  void setEnablePasscode(bool enabled) {

  }

  void setEnableFaceId(bool enabled) {

  }
}