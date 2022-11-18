import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/timer/data/helpers/ticker.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker ticker;
  StreamSubscription<int>? _subscription;

  TimerCubit({required this.ticker}) : super(const TimerPure());

  void setTimer({required Schedule schedule}) {
    DateTime currentTime = DateTime.now();
    List<Lesson> todayLessons = schedule.days[currentTime.weekday - 1];

    Lesson todayFirstLesson = todayLessons.isNotEmpty
        ? todayLessons[0]
        : const Lesson(
            number: 0,
            name: "",
            teacher: "",
            time: LessonTime(
              startTimeHour: 0,
              startTimeMinute: 0,
              endTimeHour: 0,
              endTimeMinute: 0,
            ),
            cabinet: Cabinet(name: ""),
          );
    Lesson todayLastLesson = todayLessons.isNotEmpty
        ? todayLessons[todayLessons.length - 1]
        : const Lesson(
            number: 0,
            name: "",
            teacher: "",
            time: LessonTime(
              startTimeHour: 0,
              startTimeMinute: 0,
              endTimeHour: 0,
              endTimeMinute: 0,
            ),
            cabinet: Cabinet(name: ""),
          );

    if (todayLessons.isEmpty) {
      // in case of day without lessons
      emit(const TimerDiactive(type: TimerDiactiveTypes.noLessonsToday));
      return;
    } else if (currentTime.hour > todayLastLesson.time.endTimeHour ||
        (currentTime.hour == todayLastLesson.time.endTimeHour &&
            currentTime.minute >= todayLastLesson.time.endTimeMinute)) {
      // in case of checking timer after lessons finishing
      emit(const TimerDiactive(type: TimerDiactiveTypes.afterLessons));
      return;
    } else if (currentTime.hour < todayFirstLesson.time.startTimeHour ||
        (currentTime.hour == todayFirstLesson.time.endTimeHour &&
            currentTime.minute >= todayFirstLesson.time.endTimeMinute)) {
      // in case of checking timer before lessons
      emit(const TimerDiactive(type: TimerDiactiveTypes.beforeLessons));
      return;
    } else if (todayLessons.isNotEmpty &&
        (currentTime.hour < todayLastLesson.time.endTimeHour ||
            (currentTime.hour < todayLastLesson.time.endTimeHour &&
                currentTime.minute < todayLastLesson.time.endTimeMinute))) {
      int currentLessonIndex = -1;
      int remainedMinutes = 0;
      int remainedSeconds = 0;

      // loop looks for current lesson
      for (int i = 0; i < todayLessons.length; i++) {
        if (todayLessons[i].time.startTimeHour ==
            todayLessons[i].time.endTimeHour) {
          if (currentTime.hour == todayLessons[i].time.startTimeHour &&
              currentTime.minute > todayLessons[i].time.startTimeMinute &&
              currentTime.minute < todayLessons[i].time.endTimeMinute) {
            currentLessonIndex = i;

            if (currentTime.second != 0) {
              remainedMinutes =
                  todayLessons[i].time.endTimeMinute - currentTime.minute - 1;
              remainedSeconds = 60 - currentTime.second;
            } else {
              remainedMinutes =
                  todayLessons[i].time.endTimeMinute - currentTime.minute;
              remainedSeconds = 60;
            }
          }
        } else {
          if (currentTime.hour == todayLessons[i].time.startTimeHour &&
              currentTime.minute > todayLessons[i].time.startTimeMinute) {
            currentLessonIndex = i;

            if (currentTime.second != 0) {
              remainedMinutes = 60 -
                  currentTime.minute +
                  todayLessons[i].time.endTimeMinute -
                  1;
              remainedSeconds = 60 - currentTime.second;
            } else {
              remainedMinutes =
                  60 - currentTime.minute + todayLessons[i].time.endTimeMinute;
              remainedSeconds = 60;
            }
          } else if (currentTime.hour == todayLessons[i].time.endTimeHour &&
              currentTime.minute < todayLessons[i].time.endTimeMinute) {
            currentLessonIndex = i;

            if (currentTime.second != 0) {
              remainedMinutes =
                  todayLessons[i].time.endTimeMinute - currentTime.minute - 1;
              remainedSeconds = 60 - currentTime.second;
            } else {
              remainedMinutes =
                  todayLessons[i].time.endTimeMinute - currentTime.minute;
              remainedSeconds = 60;
            }
          }
        }
      }

      if (currentLessonIndex == -1) {
        // loop looks for current break between lessons
        for (int i = 0; i < todayLessons.length; i++) {
          // check for first and lesson lessons, because we are looking for break between lessons
          if (i != 0 && i != todayLessons.length - 1) {
            if (todayLessons[i].time.endTimeHour ==
                todayLessons[i + 1].time.startTimeHour) {
              if (currentTime.hour == todayLessons[i].time.endTimeHour &&
                  currentTime.minute > todayLessons[i].time.endTimeMinute &&
                  currentTime.minute <
                      todayLessons[i + 1].time.startTimeMinute) {
                if (remainedSeconds != 0) {
                  remainedMinutes = todayLessons[i + 1].time.startTimeMinute -
                      currentTime.minute -
                      1;
                  remainedSeconds = 60 - currentTime.second;
                } else {
                  remainedMinutes = todayLessons[i + 1].time.startTimeMinute -
                      currentTime.minute;
                  remainedSeconds = 60;
                }
              }
            } else {
              if (currentTime.hour == todayLessons[i].time.endTimeHour &&
                  currentTime.minute > todayLessons[i].time.endTimeMinute) {
                if (remainedSeconds != 0) {
                  remainedMinutes = 60 -
                      currentTime.minute +
                      todayLessons[i + 1].time.startTimeMinute -
                      1;
                  remainedSeconds = 60 - currentTime.second;
                } else {
                  remainedMinutes = 60 -
                      currentTime.minute +
                      todayLessons[i + 1].time.startTimeMinute;
                  remainedSeconds = 60;
                }
              } else if (currentTime.hour ==
                      todayLessons[i + 1].time.startTimeHour &&
                  currentTime.minute <
                      todayLessons[i + 1].time.startTimeMinute) {
                if (remainedSeconds != 0) {
                  remainedMinutes = todayLessons[i + 1].time.startTimeMinute -
                      currentTime.minute -
                      1;
                  remainedSeconds = 60 - currentTime.second;
                } else {
                  remainedMinutes = todayLessons[i + 1].time.startTimeMinute -
                      currentTime.minute;
                  remainedSeconds = 60;
                }
              }
            }

            int remainedDuration = remainedMinutes * 60 + remainedSeconds;

            _subscription?.cancel();
            _subscription = ticker
                .tick(ticksNumber: remainedDuration)
                .listen((remainedTicks) {
              // call tick method, but before it write tick method
            });

            emit(
              TimerRunInProgress(
                duration: remainedDuration,
                type: currentLessonIndex != -1
                    ? TimerActiveTypes.lesson
                    : TimerActiveTypes.timeout,
              ),
            );
          }
        }
      }
    }
  }
}
