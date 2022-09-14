import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class Language {
  Locale locale;
  String langName;
  String flag;

  Language({
    required this.locale,
    required this.langName,
    required this.flag,
  });

  static List<Language> languageList = [
    Language(
        langName: 'English - UK',
        locale: const Locale('en', "US"),
        flag: _getFlag("gb")
    ),
    Language(
        langName: 'Deutsch - DE',
        locale: const Locale('de', "DE"),
        flag: _getFlag("de")
    )
  ];

  static String _getFlag(String countryCode) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) {
      int codeUnitAt = match.group(0)?.codeUnitAt(0) ?? 0;
      return String.fromCharCode(codeUnitAt + 127397);
    });
    return flag;
  }
}

class LocalizationService extends GetxService {
  static final LocalizationService _instance = new LocalizationService._internal();

  factory LocalizationService() {
    return _instance;
  }

  LocalizationService._internal();

  Language currentLanguage() {
    return Language.languageList.singleWhere((e) => e.locale == _currentLocale());
  }

  String appTitle() {
    return "Sample";
  }

  Language getLocaleLanguage() {
    Locale currentLocale = Get.context?.locale ?? Locale("en", "US");
    if (_context() != null) {
      currentLocale = _context()!.locale;
    }
    return Language.languageList.firstWhere(
            (element) => element.locale == currentLocale);
  }

  Future<void> changeLanguage(Language language) async {
    BuildContext? context = _context();

    if (context != null){
      print("Change to " + language.langName);
      await context.setLocale(language.locale);
      await EasyLocalization.of(context)?.setLocale(language.locale);
      await Get.updateLocale(language.locale);
    } else {
      print("context == null");
    }
  }

  @override
  bool isSupported(Locale locale) {
    return Language.languageList
        .map((e) => e.locale.languageCode)
        .toList()
        .contains(locale.languageCode);
  }

  //private

  Locale _currentLocale() {
    if (_context() == null) { return Language.languageList.first.locale; }
    return _context()!.locale;
  }

  BuildContext? _context() {
    return AppGlobalKeys.materialKey.currentContext ?? Get.context;
}
}