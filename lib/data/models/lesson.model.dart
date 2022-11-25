import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';

class Lesson {
  final int number;
  final String name;
  final String? teacher;
  final LessonTime time;
  final Cabinet cabinet;
  final List<String>? classes;
  final String? group;
  final bool window;

  const Lesson({
    required this.number,
    required this.name,
    this.teacher,
    required this.time,
    required this.cabinet,
    this.classes,
    this.group,
    this.window = false,
  });

  factory Lesson.fromJson({required Map<String, dynamic> json}) {
    return Lesson(
      number: json["period"]["number"],
      name: json["subject"],
      time: LessonTime.fromJson(json: json["period"]),
      cabinet: Cabinet.fromJson(json: json),
      teacher: json["teacher"],
    );
  }
}
