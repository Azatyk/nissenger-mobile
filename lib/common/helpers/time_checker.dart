import 'package:nissenger_mobile/data/models/lesson.model.dart';

class TimeChecker {
  const TimeChecker();

  static bool isCurrentTimeInLesson({required Lesson lesson}) {
    DateTime currentTime = DateTime.now();

    if (lesson.time.startTimeHour == lesson.time.endTimeHour) {
      if (currentTime.hour == lesson.time.startTimeHour &&
          currentTime.minute >= lesson.time.startTimeMinute &&
          currentTime.minute < lesson.time.endTimeMinute) {
        return true;
      } else {
        return false;
      }
    } else {
      if (currentTime.hour == lesson.time.startTimeHour &&
          currentTime.minute >= lesson.time.startTimeMinute) {
        return true;
      } else if (currentTime.hour == lesson.time.endTimeHour &&
          currentTime.minute < lesson.time.endTimeMinute) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool isCurrentTimeInTimeoutBetweenLessons(
      {required Lesson finishedLesson, required Lesson startingLesson}) {
    DateTime currentTime = DateTime.now();

    if (finishedLesson.time.endTimeHour == startingLesson.time.startTimeHour) {
      if (currentTime.hour == finishedLesson.time.endTimeHour &&
          currentTime.minute >= finishedLesson.time.endTimeMinute &&
          currentTime.minute < startingLesson.time.startTimeMinute) {
        return true;
      } else {
        return false;
      }
    } else {
      if (currentTime.hour == finishedLesson.time.endTimeHour &&
          currentTime.minute >= finishedLesson.time.endTimeMinute) {
        return true;
      } else if (currentTime.hour == startingLesson.time.startTimeHour &&
          currentTime.minute < startingLesson.time.startTimeMinute) {
        return true;
      } else {
        return false;
      }
    }
  }
}
