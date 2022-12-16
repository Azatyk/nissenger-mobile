import 'package:nissenger_mobile/data/models/lesson.model.dart';

class TimerCounter {
  const TimerCounter();

  static int countRemainedTime({
    required List<Lesson> todayLessons,
    required int activeIndex,
    required bool isTimeout,
  }) {
    DateTime currentTime = DateTime.now();
    int currentTimeInSeconds =
        currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;

    int remainedTimeInSeconds = 0;

    if (!isTimeout) {
      int lessonEndTimeInSeconds =
          todayLessons[activeIndex].time.endTimeHour * 3600 +
              todayLessons[activeIndex].time.endTimeMinute * 60;

      remainedTimeInSeconds = lessonEndTimeInSeconds - currentTimeInSeconds;
    } else {
      int nextLessonStartTimeInSeconds =
          todayLessons[activeIndex + 1].time.startTimeHour * 3600 +
              todayLessons[activeIndex + 1].time.startTimeMinute * 60;

      remainedTimeInSeconds =
          nextLessonStartTimeInSeconds - currentTimeInSeconds;
    }

    return remainedTimeInSeconds;
  }
}
