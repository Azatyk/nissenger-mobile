import 'package:flutter/material.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class WeekdayConverter {
  static String indexToWeekday(
      {required int index, required BuildContext context}) {
    switch (index) {
      case 0:
        return LangKeys.monday.translate(context);
      case 1:
        return LangKeys.tuesday.translate(context);
      case 2:
        return LangKeys.wednesday.translate(context);
      case 3:
        return LangKeys.thursday.translate(context);
      case 4:
        return LangKeys.friday.translate(context);
      case 5:
        return LangKeys.saturday.translate(context);
      default:
        return "";
    }
  }
}
