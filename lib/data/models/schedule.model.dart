import 'package:nissenger_mobile/data/models/lesson.model.dart';

class Schedule {
  final List<Lesson> mondayLessons;
  final List<Lesson> tuesdayLessons;
  final List<Lesson> wednesdayLessons;
  final List<Lesson> thursdayLessons;
  final List<Lesson> fridayLessons;
  final List<Lesson> saturdayLessons;
  final List<Lesson> sundayLessons;

  const Schedule({
    required this.mondayLessons,
    required this.tuesdayLessons,
    required this.wednesdayLessons,
    required this.thursdayLessons,
    required this.fridayLessons,
    required this.saturdayLessons,
    required this.sundayLessons,
  });
}
