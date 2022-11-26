import 'package:nissenger_mobile/data/models/lesson.model.dart';

class Schedule {
  final List<List<Lesson>> days;

  const Schedule({
    required this.days,
  });

  factory Schedule.fromJson(
      {required Map<String, dynamic> json, required bool teacherSchedule}) {
    return Schedule(
      days: (json["timetable"]["lessons"] as List)
          .map(
            (day) => (day as List)
                .map(
                  (lessonJson) => Lesson.fromJson(
                      json: lessonJson, teacherLesson: teacherSchedule),
                )
                .toList(),
          )
          .toList(),
    );
  }
}
