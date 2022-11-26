import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';

class Lesson {
  final int number;
  final String name;
  final String? teacher;
  final LessonTime time;
  final Cabinet cabinet;
  List<Class>? classes;
  String? group;
  final bool window;

  Lesson({
    required this.number,
    required this.name,
    this.teacher,
    required this.time,
    required this.cabinet,
    this.classes,
    this.group,
    this.window = false,
  });

  factory Lesson.fromJson({
    required Map<String, dynamic> json,
    required bool teacherLesson,
  }) {
    Lesson lesson = Lesson(
      number: json["period"]["number"],
      name: json["subject"],
      time: LessonTime.fromJson(json: json["period"]),
      cabinet: Cabinet.fromJson(json: json),
      teacher: json["teacher"],
    );

    if (teacherLesson) {
      if ((json["group"]["classes"] as List).length == 1) {
        lesson.classes = [
          Class.fromJson(
            json: json["group"]["classes"][0],
          ),
        ];
      } else {
        lesson.classes = (json["group"]["classes"] as List)
            .map((classJson) => Class.fromJson(json: classJson))
            .toList();
      }

      lesson.group = json["group"]["name"];
    }

    return lesson;
  }
}
