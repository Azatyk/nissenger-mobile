class LessonTimeText {
  static String time({
    required int startTimeHour,
    required int startTimeMinute,
    required int endTimeHour,
    required int endTimeMinute,
  }) {
    return "${startTimeHour.toString().padLeft(2, "0")}:${startTimeMinute.toString().padLeft(2, "0")} — ${endTimeHour.toString().padLeft(2, "0")}:${endTimeMinute.toString().padLeft(2, "0")}";
  }
}
