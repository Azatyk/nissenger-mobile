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

  static bool isCurrentTimeInWindow({required Lesson windowLesson}) {
    DateTime currentTime = DateTime.now();

    if (windowLesson.time.startTimeHour == windowLesson.time.endTimeHour) {
      if (currentTime.hour == windowLesson.time.startTimeHour &&
          currentTime.minute >= windowLesson.time.startTimeMinute &&
          currentTime.minute < windowLesson.time.endTimeMinute) {
        return true;
      } else {
        return false;
      }
    } else if (windowLesson.time.endTimeHour -
            windowLesson.time.startTimeHour ==
        1) {
      if (currentTime.hour == windowLesson.time.startTimeHour &&
          currentTime.minute >= windowLesson.time.startTimeMinute) {
        return true;
      } else if (currentTime.hour == windowLesson.time.endTimeHour &&
          currentTime.minute < windowLesson.time.endTimeMinute) {
        return true;
      } else {
        return false;
      }
    } else if (currentTime.hour > windowLesson.time.startTimeHour &&
        currentTime.hour < windowLesson.time.endTimeHour) {
      return true;
    } else {
      return false;
    }
  }
}
