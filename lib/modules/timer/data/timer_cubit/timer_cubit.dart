import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/schedule/data/mock/mock_schedule.dart';
import 'package:nissenger_mobile/modules/timer/data/helpers/ticker.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_cubit/timer_state.dart';
import 'package:nissenger_mobile/modules/timer/data/types/timer_types.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker ticker;
  StreamSubscription<int>? _subscription;

  TimerCubit({required this.ticker}) : super(const TimerPure()) {
    setTimer(schedule: MockSchedule.getMockSchedule());
  }

  int currentLessonIndex = -1;
  int lessonBeforeCurrentTimeoutIndex = -1;
  int remainedMinutes = 0;
  int remainedSeconds = 0;
  List<Lesson> todayLessons = [];

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void setTimer({required Schedule schedule}) {
    DateTime currentTime = DateTime.now();
    todayLessons = schedule.days[currentTime.weekday - 1];

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
        (currentTime.hour == todayFirstLesson.time.startTimeHour &&
            currentTime.minute < todayFirstLesson.time.startTimeMinute)) {
      // in case of checking timer before lessons
      emit(const TimerDiactive(type: TimerDiactiveTypes.beforeLessons));
      return;
    } else if (currentTime.hour < todayLastLesson.time.endTimeHour ||
        (currentTime.hour == todayLastLesson.time.endTimeHour &&
            currentTime.minute < todayLastLesson.time.endTimeMinute)) {
      // loop looks for current lesson
      for (int i = 0; i < todayLessons.length; i++) {
        _findTimeBeforeLesson(todayLessonsCheckingIndex: i);
      }

      if (currentLessonIndex == -1) {
        // loop looks for current break between lessons
        for (int i = 0; i < todayLessons.length; i++) {
          // check for first and lesson lessons, because we are looking for break between lessons
          _findTimeBeforeTimeout(todayLessonsCheckingIndex: i);
        }
      }

      int remainedDuration = remainedMinutes * 60 + remainedSeconds;

      _subscription?.cancel();
      _subscription =
          ticker.tick(ticksNumber: remainedDuration).listen((remainedTicks) {
        _tick(remainedTicks: remainedTicks);
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

  void _tick({required int remainedTicks}) {
    if (remainedTicks > 0) {
      emit(
        (state as TimerRunInProgress).copyWith(
          duration: remainedTicks,
        ),
      );
    } else {
      _onTimerFinished();
    }
  }

  void _onTimerFinished() {
    if (currentLessonIndex != -1) {
      if (currentLessonIndex != (todayLessons.length - 1)) {
        lessonBeforeCurrentTimeoutIndex = currentLessonIndex;
        currentLessonIndex = -1;

        _findTimeBeforeTimeout(
            todayLessonsCheckingIndex: lessonBeforeCurrentTimeoutIndex);
      } else {
        emit(
          const TimerDiactive(
            type: TimerDiactiveTypes.afterLessons,
          ),
        );
        return;
      }
    } else if (lessonBeforeCurrentTimeoutIndex != -1) {
      currentLessonIndex = lessonBeforeCurrentTimeoutIndex + 1;
      lessonBeforeCurrentTimeoutIndex = -1;

      _findTimeBeforeLesson(todayLessonsCheckingIndex: currentLessonIndex);
    }

    int remainedDuration = remainedMinutes * 60 + remainedSeconds;

    _subscription?.cancel();
    _subscription =
        ticker.tick(ticksNumber: remainedDuration).listen((remainedTicks) {
      _tick(remainedTicks: remainedTicks);
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

  void _findTimeBeforeLesson({required int todayLessonsCheckingIndex}) {
    DateTime currentTime = DateTime.now();

    if (todayLessons[todayLessonsCheckingIndex].time.startTimeHour ==
        todayLessons[todayLessonsCheckingIndex].time.endTimeHour) {
      if (currentTime.hour ==
              todayLessons[todayLessonsCheckingIndex].time.startTimeHour &&
          currentTime.minute >=
              todayLessons[todayLessonsCheckingIndex].time.startTimeMinute &&
          currentTime.minute <
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute) {
        currentLessonIndex = todayLessonsCheckingIndex;

        if (currentTime.second != 0) {
          remainedMinutes =
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
                  currentTime.minute -
                  1;
          remainedSeconds = 60 - currentTime.second;
        } else {
          remainedMinutes =
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
                  currentTime.minute -
                  1;
          remainedSeconds = 60;
        }
      }
    } else {
      if (currentTime.hour ==
              todayLessons[todayLessonsCheckingIndex].time.startTimeHour &&
          currentTime.minute >
              todayLessons[todayLessonsCheckingIndex].time.startTimeMinute) {
        currentLessonIndex = todayLessonsCheckingIndex;

        if (currentTime.second != 0) {
          remainedMinutes = 60 -
              currentTime.minute +
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
              1;
          remainedSeconds = 60 - currentTime.second;
        } else {
          remainedMinutes = 60 -
              currentTime.minute +
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
              1;
          remainedSeconds = 60;
        }
      } else if (currentTime.hour ==
              todayLessons[todayLessonsCheckingIndex].time.endTimeHour &&
          currentTime.minute <
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute) {
        currentLessonIndex = todayLessonsCheckingIndex;

        if (currentTime.second != 0) {
          remainedMinutes =
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
                  currentTime.minute -
                  1;
          remainedSeconds = 60 - currentTime.second;
        } else {
          remainedMinutes =
              todayLessons[todayLessonsCheckingIndex].time.endTimeMinute -
                  currentTime.minute -
                  1;
          remainedSeconds = 60;
        }
      }
    }
  }

  void _findTimeBeforeTimeout({required int todayLessonsCheckingIndex}) {
    DateTime currentTime = DateTime.now();

    if (todayLessonsCheckingIndex != 0 &&
        todayLessonsCheckingIndex != todayLessons.length - 1) {
      if (todayLessons[todayLessonsCheckingIndex].time.endTimeHour ==
          todayLessons[todayLessonsCheckingIndex + 1].time.startTimeHour) {
        if (currentTime.hour ==
                todayLessons[todayLessonsCheckingIndex].time.endTimeHour &&
            currentTime.minute >=
                todayLessons[todayLessonsCheckingIndex].time.endTimeMinute &&
            currentTime.minute <
                todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute) {
          lessonBeforeCurrentTimeoutIndex = todayLessonsCheckingIndex;

          if (currentTime.second != 0) {
            remainedMinutes = todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                currentTime.minute -
                1;
            remainedSeconds = 60 - currentTime.second;
          } else {
            remainedMinutes = todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                currentTime.minute -
                1;
            remainedSeconds = 60;
          }
        }
      } else {
        if (currentTime.hour ==
                todayLessons[todayLessonsCheckingIndex].time.endTimeHour &&
            currentTime.minute >=
                todayLessons[todayLessonsCheckingIndex].time.endTimeMinute) {
          lessonBeforeCurrentTimeoutIndex = todayLessonsCheckingIndex;

          if (currentTime.second != 0) {
            remainedMinutes = 60 -
                currentTime.minute +
                todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                1;
            remainedSeconds = 60 - currentTime.second;
          } else {
            remainedMinutes = 60 -
                currentTime.minute +
                todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                1;
            remainedSeconds = 60;
          }
        } else if (currentTime.hour ==
                todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeHour &&
            currentTime.minute <
                todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute) {
          lessonBeforeCurrentTimeoutIndex = todayLessonsCheckingIndex;

          if (currentTime.second != 0) {
            remainedMinutes = todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                currentTime.minute -
                1;
            remainedSeconds = 60 - currentTime.second;
          } else {
            remainedMinutes = todayLessons[todayLessonsCheckingIndex + 1]
                    .time
                    .startTimeMinute -
                currentTime.minute -
                1;
            remainedSeconds = 60;
          }
        }
      }
    }
  }
}
