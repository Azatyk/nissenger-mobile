import 'package:nissenger_mobile/data/models/lesson.model.dart';

class ActiveLessonFinder {
  const ActiveLessonFinder();

  static bool isTimeBeforeLesson({required Lesson lesson}) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int lessonStartTimeInSeconds =
        lesson.time.startTimeHour * 3600 + lesson.time.startTimeMinute * 60;

    return currentTimeInSeconds < lessonStartTimeInSeconds;
  }

  static bool isTimeAfterLesson({required Lesson lesson}) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int lessonEndTimeInSeconds =
        lesson.time.endTimeHour * 3600 + lesson.time.endTimeMinute * 60;

    return currentTimeInSeconds >= lessonEndTimeInSeconds;
  }

  static bool isCurrentTimeInLesson({required Lesson lesson}) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int lessonStartTimeInSeconds =
        lesson.time.startTimeHour * 3600 + lesson.time.startTimeMinute * 60;
    int lessonEndTimeInSeconds =
        lesson.time.endTimeHour * 3600 + lesson.time.endTimeMinute * 60;

    return currentTimeInSeconds >= lessonStartTimeInSeconds &&
        currentTimeInSeconds < lessonEndTimeInSeconds;
  }

  static bool isCurrentTimeInTimeoutBetweenLessons(
      {required Lesson finishedLesson, required Lesson startingLesson}) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int finishedLessonEndTimeInSeconds =
        finishedLesson.time.endTimeHour * 3600 +
            finishedLesson.time.endTimeMinute * 60;
    int startingLessonStartTimeInSeconds =
        startingLesson.time.startTimeHour * 3600 +
            startingLesson.time.startTimeMinute * 60;

    return currentTimeInSeconds >= finishedLessonEndTimeInSeconds &&
        currentTimeInSeconds < startingLessonStartTimeInSeconds;
  }

  static bool isCurrentTimeInWindow({required Lesson windowLesson}) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int windowLessonStartTimeInSeconds =
        windowLesson.time.startTimeHour * 3600 +
            windowLesson.time.startTimeMinute * 60;
    int windowLessonEndTimeInSeconds = windowLesson.time.endTimeHour * 3600 +
        windowLesson.time.endTimeMinute * 60;

    return currentTimeInSeconds >= windowLessonStartTimeInSeconds &&
        currentTimeInSeconds < windowLessonEndTimeInSeconds;
  }
}
