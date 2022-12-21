class Weekday {
  final String uiTitle;
  final String name;

  const Weekday({
    required this.uiTitle,
    required this.name,
  });
}

class WeekdaysData {
  static List<Weekday> weekdays = const [
    Weekday(
      uiTitle: "Понедельник",
      name: "monday",
    ),
    Weekday(
      uiTitle: "Вторник",
      name: "tuesday",
    ),
    Weekday(
      uiTitle: "Среда",
      name: "wednesday",
    ),
    Weekday(
      uiTitle: "Четверг",
      name: "thursday",
    ),
    Weekday(
      uiTitle: "Пятница",
      name: "friday",
    ),
    Weekday(
      uiTitle: "Суббота",
      name: "saturday",
    ),
  ];
}
