import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';

class ScheduleParser {
  static Schedule addWindows({required Schedule schedule}) {
    for (int i = 0; i < schedule.days.length; i++) {
      List<Lesson> parsedLessonsList = [];

      if (schedule.days[i].isNotEmpty && schedule.days[i][0].number != 1) {
        for (int k = 1; k < schedule.days[i][0].number; k++) {
          parsedLessonsList.add(
            Lesson(
              number: k,
              name: "",
              time: const LessonTime(
                startTimeHour: 0,
                startTimeMinute: 0,
                endTimeHour: 0,
                endTimeMinute: 0,
              ),
              cabinet: const Cabinet(name: ""),
              window: true,
            ),
          );
        }
      }

      for (int j = 0; j < schedule.days[i].length; j++) {
        if (j != schedule.days[i].length - 1) {
          if (schedule.days[i][j].number !=
              schedule.days[i][j + 1].number + 1) {
            int numberOfWindows =
                schedule.days[i][j + 1].number - schedule.days[i][j].number - 1;
            parsedLessonsList.add(schedule.days[i][j]);

            for (int i = 0; i < numberOfWindows; i++) {
              parsedLessonsList.add(
                Lesson(
                  number: 0,
                  name: "",
                  time: const LessonTime(
                    startTimeHour: 0,
                    startTimeMinute: 0,
                    endTimeHour: 0,
                    endTimeMinute: 0,
                  ),
                  cabinet: const Cabinet(name: ""),
                  window: true,
                ),
              );
            }
          } else {
            parsedLessonsList.add(schedule.days[i][j]);
          }
        } else {
          parsedLessonsList.add(schedule.days[i][j]);
        }
      }

      schedule.days[i] = parsedLessonsList;
    }

    return schedule;
  }

  static Schedule joinSameTimeLessons({required Schedule schedule}) {
    for (int i = 0; i < schedule.days.length; i++) {
      for (int j = 0; j < schedule.days[i].length; j++) {
        if (j != schedule.days[i].length - 1) {
          if (schedule.days[i][j].number == schedule.days[i][j + 1].number &&
              schedule.days[i][j].name == schedule.days[i][j + 1].name) {
            schedule.days[i][j].joined = true;
            schedule.days[i].removeAt(j + 1);
          }
        }
      }
    }

    return schedule;
  }
}
