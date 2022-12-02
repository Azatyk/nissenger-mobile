import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/helpers/time_checker.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_current_lesson_cubit/schedule_current_lesson_state.dart';

class ScheduleCurrentLessonCubit extends Cubit<ScheduleCurrentLessonState> {
  ScheduleCurrentLessonCubit() : super(const ScheduleCurrentLessonPure());

  void checkActiveLesson({required List<Lesson> todayLessons}) {
    for (int i = 0; i < todayLessons.length; i++) {
      if (!todayLessons[i].window) {
        if (TimeChecker.isCurrentTimeInLesson(lesson: todayLessons[i])) {
          emit(ScheduleCurrentLessonIndex(index: i));

          break;
        }
      } else {
        if (TimeChecker.isCurrentTimeInWindow(windowLesson: todayLessons[i])) {
          emit(ScheduleCurrentLessonIndex(index: i));

          break;
        }
      }
    }
  }
}
