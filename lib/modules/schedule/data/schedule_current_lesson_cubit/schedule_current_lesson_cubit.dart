import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/helpers/active_lesson_finder.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_state.dart';

class ScheduleCurrentLessonCubit extends Cubit<ScheduleCurrentLessonState> {
  ScheduleCurrentLessonCubit() : super(const ScheduleCurrentLessonPure());

  void checkActiveLesson({required List<Lesson> todayLessons}) {
    for (int i = 0; i < todayLessons.length; i++) {
      if (!todayLessons[i].window) {
        if (ActiveLessonFinder.isCurrentTimeInLesson(lesson: todayLessons[i])) {
          emit(ScheduleCurrentLessonIndex(index: i));

          break;
        } else if (i + 1 != todayLessons.length) {
          if (ActiveLessonFinder.isCurrentTimeInTimeoutBetweenLessons(
              finishedLesson: todayLessons[i],
              startingLesson: todayLessons[i + 1])) {
            emit(ScheduleLessonBeforeCurrentTimeoutIndex(lessonBeforeTimeoutIndex: i));

            break;
          }
        }
      } else {
        if (ActiveLessonFinder.isCurrentTimeInWindow(
            windowLesson: todayLessons[i])) {
          emit(ScheduleCurrentLessonIndex(index: i));

          break;
        }
      }
    }
  }
}
