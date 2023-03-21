import 'package:flutter/material.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

enum ErrorTypes {
  internetConnectionError,
  unknownError,
}

enum ErrorMessageType {
  title,
  subtitle,
  mainButtonText,
  secondaryButtonText,
}

Map<ErrorTypes, Map<ErrorMessageType, String>> errorMessages(
    BuildContext context) {
  return {
    ErrorTypes.internetConnectionError: {
      ErrorMessageType.title:
          LangKeys.errorMessageNoInternetTitle.translate(context),
      ErrorMessageType.subtitle:
          LangKeys.errorMessageNoInternetSubtitle.translate(context),
      ErrorMessageType.mainButtonText:
          LangKeys.errorMessageMainBtnText.translate(context),
      ErrorMessageType.secondaryButtonText:
          LangKeys.errorMessageSecBtnText.translate(context),
    },
    ErrorTypes.unknownError: {
      ErrorMessageType.title:
          LangKeys.errorMessageUnknownTitle.translate(context),
      ErrorMessageType.subtitle:
          LangKeys.errorMessageUnknownSubtitle.translate(context),
      ErrorMessageType.mainButtonText:
          LangKeys.errorMessageMainBtnText.translate(context),
      ErrorMessageType.secondaryButtonText:
          LangKeys.errorMessageSecBtnText.translate(context),
    }
  };
}
