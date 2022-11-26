import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';

class MockSchedule {
  static final List<Lesson> _dayStudentLessons = [
    Lesson(
      number: 1,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: const LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: const Cabinet(name: "303A"),
    ),
    Lesson(
      number: 3,
      name: "Информатика",
      teacher: "Есеналина А. А.",
      time: const LessonTime(
        startTimeHour: 9,
        startTimeMinute: 40,
        endTimeHour: 10,
        endTimeMinute: 20,
      ),
      cabinet: const Cabinet(name: "116"),
    ),
    Lesson(
      number: 4,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: const LessonTime(
        startTimeHour: 10,
        startTimeMinute: 40,
        endTimeHour: 11,
        endTimeMinute: 20,
      ),
      cabinet: const Cabinet(name: "303A"),
    ),
    Lesson(
      number: 5,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: const LessonTime(
        startTimeHour: 11,
        startTimeMinute: 25,
        endTimeHour: 11,
        endTimeMinute: 55,
      ),
      cabinet: const Cabinet(name: "303A"),
    ),
    Lesson(
      number: 6,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: const LessonTime(
        startTimeHour: 12,
        startTimeMinute: 00,
        endTimeHour: 12,
        endTimeMinute: 40,
      ),
      cabinet: const Cabinet(name: "303A"),
    ),
    Lesson(
      number: 7,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: const LessonTime(
        startTimeHour: 12,
        startTimeMinute: 45,
        endTimeHour: 13,
        endTimeMinute: 25,
      ),
      cabinet: const Cabinet(name: "303A"),
    ),
  ];

  static Schedule getMockStudentSchedule() {
    return Schedule(
      days: [
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
      ],
    );
  }

  static final List<Lesson> _dayTeacherLessons = [
    Lesson(
      number: 1,
      name: "Английский язык",
      classes: [const Class(letter: "L", number: 11)],
      group: "1",
      time: const LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: const Cabinet(name: "123"),
    ),
    Lesson(
      number: 2,
      name: "Английский язык",
      classes: [
        const Class(letter: "M", number: 12),
        const Class(letter: "K", number: 12),
        const Class(letter: "D", number: 12),
      ],
      group: "И1 рус",
      time: const LessonTime(
        startTimeHour: 8,
        startTimeMinute: 50,
        endTimeHour: 9,
        endTimeMinute: 30,
      ),
      cabinet: const Cabinet(name: "313А"),
    ),
    Lesson(
      number: 3,
      name: "Английский язык",
      classes: [const Class(letter: "B", number: 9)],
      group: "2",
      time: const LessonTime(
        startTimeHour: 9,
        startTimeMinute: 40,
        endTimeHour: 10,
        endTimeMinute: 20,
      ),
      cabinet: const Cabinet(name: "145"),
    ),
    Lesson(
      number: 4,
      name: "Английский язык",
      classes: [const Class(letter: "K", number: 9)],
      group: "1",
      time: const LessonTime(
        startTimeHour: 10,
        startTimeMinute: 30,
        endTimeHour: 11,
        endTimeMinute: 10,
      ),
      cabinet: const Cabinet(name: "123"),
    ),
  ];

  static Schedule getMockTeacherSchedule() {
    return Schedule(
      days: [
        _dayTeacherLessons,
        _dayTeacherLessons,
        _dayTeacherLessons,
        _dayTeacherLessons,
        _dayTeacherLessons,
        _dayTeacherLessons,
      ],
    );
  }
}
