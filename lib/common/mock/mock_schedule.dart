import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';

class MockSchedule {
  static final List<Lesson> _dayStudentLessons = [
    const Lesson(
      number: 1,
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
      number: 2,
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
      number: 3,
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
      number: 4,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 10,
        startTimeMinute: 40,
        endTimeHour: 11,
        endTimeMinute: 20,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      number: 5,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 11,
        startTimeMinute: 25,
        endTimeHour: 11,
        endTimeMinute: 55,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      number: 6,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 12,
        startTimeMinute: 00,
        endTimeHour: 12,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
    const Lesson(
      number: 7,
      name: "Математика",
      teacher: "Бекарыс Н.",
      time: LessonTime(
        startTimeHour: 12,
        startTimeMinute: 45,
        endTimeHour: 13,
        endTimeMinute: 25,
      ),
      cabinet: Cabinet(name: "303A"),
    ),
  ];

  static Schedule getMockStudentSchedule() {
    return Schedule(
      days: [
        [..._dayStudentLessons, ..._dayStudentLessons],
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
        _dayStudentLessons,
      ],
    );
  }

  static final List<Lesson> _dayTeacherLessons = [
    const Lesson(
      number: 1,
      name: "Английский язык",
      classes: ["11L"],
      group: "1",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 0,
        endTimeHour: 8,
        endTimeMinute: 40,
      ),
      cabinet: Cabinet(name: "123"),
    ),
    const Lesson(
      number: 2,
      name: "Английский язык",
      classes: ["11M", "11K", "11D"],
      group: "И1 рус",
      time: LessonTime(
        startTimeHour: 8,
        startTimeMinute: 50,
        endTimeHour: 9,
        endTimeMinute: 30,
      ),
      cabinet: Cabinet(name: "313А"),
    ),
    const Lesson(
      number: 3,
      name: "Английский язык",
      classes: ["9B"],
      group: "2",
      time: LessonTime(
        startTimeHour: 9,
        startTimeMinute: 40,
        endTimeHour: 10,
        endTimeMinute: 20,
      ),
      cabinet: Cabinet(name: "145"),
    ),
    const Lesson(
      number: 4,
      name: "Английский язык",
      classes: ["9K"],
      group: "1",
      time: LessonTime(
        startTimeHour: 10,
        startTimeMinute: 30,
        endTimeHour: 11,
        endTimeMinute: 10,
      ),
      cabinet: Cabinet(name: "123"),
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
