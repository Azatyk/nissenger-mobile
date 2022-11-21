import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/helpers/time_checker.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/schedule/data/mock/mock_schedule.dart';
import 'package:nissenger_mobile/modules/timer/data/short_lessons_list_cubit/short_lessons_list_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/short_lessons_list_types.dart';

class ShortLessonsListCubit extends Cubit<ShortLessonsListState> {
  ShortLessonsListCubit() : super(const ShortLessonsListRequestLoading()) {
    loadSchedule();
  }

  void loadSchedule() async {
    emit(const ShortLessonsListRequestLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ShortLessonsListRequestData(
          schedule: MockSchedule.getMockSchedule(),
        ),
      );

      getLessons(schedule: MockSchedule.getMockSchedule());
    } catch (err) {
      // to do: handle errors
    }
  }

  void getLessons({required Schedule schedule}) {
    DateTime currentTime = DateTime.now();

    List<Lesson> todayLessons =
        currentTime.weekday != 7 ? schedule.days[currentTime.weekday - 1] : [];

    if (todayLessons.isEmpty) {
      // in case of no lessons today
      emit(
        ShortLessonsListData(
          threeLessons: currentTime.weekday != 6
              ? schedule.days[currentTime.weekday].take(3).toList()
              : schedule.days[0].take(3).toList(),
          numberOfRemainedLessons: currentTime.weekday != 6
              ? schedule.days[currentTime.weekday].length - 3
              : schedule.days[0].length - 3,
          lastLessonEndTime: currentTime.weekday != 6
              ? schedule
                  .days[currentTime.weekday]
                      [schedule.days[currentTime.weekday].length - 1]
                  .time
              : schedule.days[0][schedule.days[0].length - 1].time,
          type: ShortLessonsListTypes.afterLessons,
          activeLessonIndex: -1,
        ),
      );
    } else if (currentTime.hour < todayLessons[0].time.startTimeHour ||
        (currentTime.hour == todayLessons[0].time.startTimeHour &&
            currentTime.minute < todayLessons[0].time.startTimeMinute)) {
      // in case of checking timer before today lessons
      emit(
        ShortLessonsListData(
          threeLessons: todayLessons.take(3).toList(),
          numberOfRemainedLessons: todayLessons.length - 3,
          lastLessonEndTime: todayLessons[todayLessons.length - 1].time,
          type: ShortLessonsListTypes.beforeLessons,
          activeLessonIndex: -1,
        ),
      );
    } else if (currentTime.hour >
            todayLessons[todayLessons.length - 1].time.endTimeHour ||
        (currentTime.hour ==
                todayLessons[todayLessons.length - 1].time.endTimeHour &&
            currentTime.minute >=
                todayLessons[todayLessons.length - 1].time.endTimeMinute)) {
      // in case if checking timer after today lessons
      emit(
        ShortLessonsListData(
          threeLessons: currentTime.weekday != 6
              ? schedule.days[currentTime.weekday].take(3).toList()
              : schedule.days[0].take(3).toList(),
          numberOfRemainedLessons: currentTime.weekday != 6
              ? schedule.days[currentTime.weekday].length - 3
              : schedule.days[0].length - 3,
          lastLessonEndTime: currentTime.weekday != 6
              ? schedule
                  .days[currentTime.weekday]
                      [schedule.days[currentTime.weekday].length - 1]
                  .time
              : schedule.days[0][schedule.days[0].length - 1].time,
          type: ShortLessonsListTypes.afterLessons,
          activeLessonIndex: -1,
        ),
      );
    } else {
      // in case if checking timer during lessons
      LessonTime lastLessonEndTime = todayLessons[todayLessons.length - 1].time;
      if (TimeChecker.isCurrentTimeInLesson(lesson: todayLessons[0])) {
        // in case if active lesson is first
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons.take(3).toList(),
            numberOfRemainedLessons: todayLessons.length - 3,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 0,
          ),
        );
      } else if (TimeChecker.isCurrentTimeInLesson(
          lesson: todayLessons[todayLessons.length - 1])) {
        // in case if active lesson is last
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 2,
          ),
        );
      } else if (TimeChecker.isCurrentTimeInLesson(
          lesson: todayLessons[todayLessons.length - 2])) {
        // in case if active lesson is one before last
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 1,
          ),
        );
      } else if (TimeChecker.isCurrentTimeInTimeoutBetweenLessons(
          finishedLesson: todayLessons[todayLessons.length - 2],
          startingLesson: todayLessons[todayLessons.length - 1])) {
        // in case if active timeout is one before last lesson
        emit(
          ShortLessonsListData(
            threeLessons: todayLessons
                .getRange(todayLessons.length - 3, todayLessons.length)
                .toList(),
            numberOfRemainedLessons: 0,
            lastLessonEndTime: lastLessonEndTime,
            type: ShortLessonsListTypes.duringLessons,
            activeLessonIndex: 1,
            isTimeout: true,
          ),
        );
      } else {
        // in case if active lesson in middle
        int activeLessonIndex = -1;

        for (int i = 1; i < todayLessons.length - 1; i++) {
          if (TimeChecker.isCurrentTimeInLesson(lesson: todayLessons[i])) {
            activeLessonIndex = i;

            emit(
              ShortLessonsListData(
                threeLessons: todayLessons.getRange(i, i + 3).toList(),
                numberOfRemainedLessons: todayLessons.length - (i + 3),
                lastLessonEndTime: lastLessonEndTime,
                type: ShortLessonsListTypes.duringLessons,
                activeLessonIndex: 0,
              ),
            );

            break;
          }
        }

        if (activeLessonIndex == -1) {
          for (int i = 0; i < todayLessons.length; i++) {
            if (i != todayLessons.length - 1) {
              if (TimeChecker.isCurrentTimeInTimeoutBetweenLessons(
                  finishedLesson: todayLessons[i],
                  startingLesson: todayLessons[i + 1])) {
                emit(
                  ShortLessonsListData(
                    threeLessons: todayLessons.getRange(i, i + 3).toList(),
                    numberOfRemainedLessons: todayLessons.length - (i + 3),
                    lastLessonEndTime: lastLessonEndTime,
                    type: ShortLessonsListTypes.duringLessons,
                    activeLessonIndex: 0,
                    isTimeout: true,
                  ),
                );

                break;
              }
            }
          }
        }
      }
    }
  }
}
