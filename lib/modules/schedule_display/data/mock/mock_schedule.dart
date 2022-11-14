import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';

class MockSchedule {
  static final List<Lesson> _dayLessons = [
    const Lesson(
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      name: "Информатика",
      teacher: "Есеналина А. А.",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 50,
        endTimeHour: 9,
        endTimeMinute: 30,
      ),
      cabinet: Cabinet(name: "116"),
    ),
    const Lesson(
      name: "Информатика",
      teacher: "Есеналина А. А.",
      time: LessonTime(
        startTimeHour: 9,
        startTimeMinute: 40,
        endTimeHour: 10,
        endTimeMinute: 20,
      ),
      cabinet: Cabinet(name: "116"),
    ),
    const Lesson(
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
  ];

  static Schedule getMockSchedule() {
    return Schedule(
      mondayLessons: _dayLessons,
      tuesdayLessons: _dayLessons,
      wednesdayLessons: _dayLessons,
      thursdayLessons: _dayLessons,
      fridayLessons: _dayLessons,
      saturdayLessons: _dayLessons,
      sundayLessons: [],
    );
  }
}
