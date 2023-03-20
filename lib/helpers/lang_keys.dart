import 'package:nissenger_mobile/helpers/localization_service.dart';

enum LangKeys {
  text,
}

extension LangKeysExtension on LangKeys {
  String get key => toString().split(".")[1];

  String translate(context) {
    return LocalizationService.of(context).translate(key) ?? "";
  }
}
