import 'package:flutter/material.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';

class Weekday {
  final String uiTitle;
  final String name;

  const Weekday({
    required this.uiTitle,
    required this.name,
  });
}

class WeekdaysData {
  static List<Weekday> weekdays(BuildContext context) {
    return [
      Weekday(
        uiTitle: LangKeys.monday.translate(context),
        name: "monday",
      ),
      Weekday(
        uiTitle: LangKeys.tuesday.translate(context),
        name: "tuesday",
      ),
      Weekday(
        uiTitle: LangKeys.wednesday.translate(context),
        name: "wednesday",
      ),
      Weekday(
        uiTitle: LangKeys.thursday.translate(context),
        name: "thursday",
      ),
      Weekday(
        uiTitle: LangKeys.friday.translate(context),
        name: "friday",
      ),
      Weekday(
        uiTitle: LangKeys.saturday.translate(context),
        name: "saturday",
      ),
    ];
  }
}
