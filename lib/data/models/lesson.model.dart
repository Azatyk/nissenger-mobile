import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';

class Lesson {
  final String name;
  final String teacher;
  final LessonTime time;
  final Cabinet cabinet;

  const Lesson({
    required this.name,
    required this.teacher,
    required this.time,
    required this.cabinet,
  });
}
