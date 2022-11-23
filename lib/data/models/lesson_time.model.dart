class LessonTime {
  final int startTimeHour;
  final int startTimeMinute;
  final int endTimeHour;
  final int endTimeMinute;

  const LessonTime({
    required this.startTimeHour,
    required this.startTimeMinute,
    required this.endTimeHour,
    required this.endTimeMinute,
  });

  factory LessonTime.fromJson({required Map<String, dynamic> json}) {
    return LessonTime(
      startTimeHour: int.parse(
          json["period"]["start_time"][0] + json["period"]["start_time"][1]),
      startTimeMinute: int.parse(
          json["period"]["start_time"][3] + json["period"]["start_time"][4]),
      endTimeHour: int.parse(
          json["period"]["end_time"][0] + json["period"]["end_time"][1]),
      endTimeMinute: int.parse(
          json["period"]["end_time"][3] + json["period"]["end_time"][4]),
    );
  }
}
