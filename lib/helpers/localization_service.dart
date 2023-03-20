import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class LocalizationService {
  late final Locale locale;

  static late final Locale currentLocale;

  LocalizationService(this.locale) {
    currentLocale = locale;
  }

  static LocalizationService of(BuildContext context) {
    return Localizations.of(context, LocalizationService);
  }

  late Map<String, String> localizedString;

  Future<void> load() async {
    final jsonString =
        await rootBundle.loadString("lang/${locale.languageCode}.json");

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    localizedString = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String? translate(String key) {
    return localizedString[key];
  }

  static const supportedLocalesList = [
    Locale("ru", "RU"),
    Locale("kk", "KZ"),
  ];

  static Locale? localResolutionCallBack(
      Locale? locale, Iterable<Locale>? supportedLocales) {
    if (supportedLocales != null && locale != null) {
      return supportedLocales.firstWhere(
          (element) => element.languageCode == locale.languageCode,
          orElse: () => supportedLocales.first);
    }

    return null;
  }

  static const LocalizationsDelegate<LocalizationService> delegate =
      LocalizationServiceDelegate();

  static const localizationsDelegate = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    delegate
  ];
}

class LocalizationServiceDelegate
    extends LocalizationsDelegate<LocalizationService> {
  const LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["ru", "kk"].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }
}

class LocalizationController extends GetxController {
  String currentLanguage = "".obs.toString();

  void toggleLanguage() {
    currentLanguage =
        LocalizationService.currentLocale.languageCode == 'ru' ? 'kk' : 'ru';
    update();
  }
}
