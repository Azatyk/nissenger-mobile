import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/helpers/ticker.dart';
import 'package:nissenger_mobile/helpers/active_lesson_finder.dart';
import 'package:nissenger_mobile/helpers/timer_counter.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker ticker;
  StreamSubscription<int>? _subscription;

  TimerCubit({required this.ticker}) : super(const TimerPure());

  List<Lesson> todayLessons = [];

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void setTimer({required Schedule schedule}) {
    // indexes for checking current kind of lesson and its index
    int currentLessonIndex = -1;
    int currentWindowIndex = -1;
    int lessonBeforeCurrentTimeoutIndex = -1;

    _subscription?.cancel();

    DateTime currentTime = DateTime.now();
    // set monday lessons in case of today is sunday, because we don't handle sunday
    todayLessons =
        currentTime.weekday != 7 ? schedule.days[currentTime.weekday - 1] : [];

    if (todayLessons.isEmpty) {
      // in case of no lessons today
      emit(const TimerDiactive(type: TimerDiactiveTypes.noLessonsToday));
    } else if (ActiveLessonFinder.isTimeBeforeLesson(lesson: todayLessons[0])) {
      // in case of checking before today lessons
      emit(const TimerDiactive(type: TimerDiactiveTypes.beforeLessons));

      // set timer till lessons start only before one hour in case of checking before today lessons
      if (currentTime.hour == todayLessons[0].time.startTimeHour - 1) {
        int remainedMinutes = 60 - currentTime.minute - 1;
        int remainedSeconds =
            currentTime.second != 0 ? 60 - currentTime.second : 60;

        int remainedDuration = remainedMinutes * 60 + remainedSeconds;

        _subscription?.cancel();
        _subscription =
            ticker.tick(ticksNumber: remainedDuration).listen((remainedTicks) {
          if (remainedTicks == 0) {
            emit(TimerChangeDuration(schedule: schedule));

            setTimer(schedule: schedule);
          }
        });
      }
    } else if (ActiveLessonFinder.isTimeAfterLesson(
        lesson: todayLessons[todayLessons.length - 1])) {
      // in case of checking after today lessons
      emit(const TimerDiactive(type: TimerDiactiveTypes.afterLessons));
    } else {
      // in case of checking during the lessons
      for (int i = 0; i < todayLessons.length; i++) {
        // check if aalready found active item, break loop for optimization
        if (currentLessonIndex != -1 ||
            currentWindowIndex != -1 ||
            lessonBeforeCurrentTimeoutIndex != -1) {
          break;
        }

        // check is active or window active
        if (!todayLessons[i].window) {
          if (ActiveLessonFinder.isCurrentTimeInLesson(
              lesson: todayLessons[i])) {
            currentLessonIndex = i;
          }
        } else {
          if (ActiveLessonFinder.isCurrentTimeInWindow(
              windowLesson: todayLessons[i])) {
            currentWindowIndex = i;
          }
        }

        // if lesson of window is not active and its not last or first lessons, check for timeout
        if (i != todayLessons.length - 1 &&
            currentLessonIndex == -1 &&
            currentWindowIndex == -1) {
          if (ActiveLessonFinder.isCurrentTimeInTimeoutBetweenLessons(
              finishedLesson: todayLessons[i],
              startingLesson: todayLessons[i + 1])) {
            lessonBeforeCurrentTimeoutIndex = i;
          }
        }
      }

      int activeIndex = currentLessonIndex != -1
          ? currentLessonIndex
          : currentWindowIndex != -1
              ? currentWindowIndex
              : lessonBeforeCurrentTimeoutIndex;

      int remainedTime = TimerCounter.countRemainedTime(
        todayLessons: todayLessons,
        activeIndex: activeIndex,
        isTimeout: lessonBeforeCurrentTimeoutIndex != -1,
      );

      _subscription?.cancel();
      _subscription =
          ticker.tick(ticksNumber: remainedTime).listen((remainedTicks) {
        _tick(
          schedule: schedule,
          remainedTicks: remainedTicks,
        );
      });

      emit(
        TimerRunInProgress(
          duration: remainedTime,
          type: currentLessonIndex != -1
              ? TimerActiveTypes.lesson
              : currentWindowIndex != -1
                  ? TimerActiveTypes.window
                  : TimerActiveTypes.timeout,
        ),
      );
    }
  }

  void _tick({
    required Schedule schedule,
    required int remainedTicks,
  }) {
    if (remainedTicks > 0) {
      emit(
        (state as TimerRunInProgress).copyWith(
          duration: remainedTicks,
        ),
      );
    } else {
      emit(TimerChangeDuration(schedule: schedule));
      setTimer(schedule: schedule);
    }
  }

  void stopTimer() {
    _subscription?.cancel();

    emit(const TimerPure());
  }
}
