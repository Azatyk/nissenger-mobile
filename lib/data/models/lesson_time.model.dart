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
        json["start_time"][0] + json["start_time"][1],
      ),
      startTimeMinute: int.parse(
        json["start_time"][3] + json["start_time"][4],
      ),
      endTimeHour: int.parse(
        json["end_time"][0] + json["end_time"][1],
      ),
      endTimeMinute: int.parse(
        json["end_time"][3] + json["end_time"][4],
      ),
    );
  }
}
