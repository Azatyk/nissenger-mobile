import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_current_lesson_cubit/schedule_current_lesson_state.dart';

class ScheduleCurrentLessonCubit extends Cubit<ScheduleCurrentLessonState> {
  ScheduleCurrentLessonCubit() : super(const ScheduleCurrentLessonPure());

  void checkActiveLesson({required List<Lesson> todayLessons}) {
    DateTime currentTime = DateTime.now();

    for (int i = 0; i < todayLessons.length; i++) {
      if (currentTime.hour.toInt() == todayLessons[i].time.startTimeHour) {
        if (currentTime.hour.toInt() == todayLessons[i].time.endTimeHour &&
                currentTime.minute.toInt() <
                    todayLessons[i].time.endTimeMinute ||
            currentTime.hour.toInt() < todayLessons[i].time.endTimeHour) {
          emit(
            ScheduleCurrentLessonIndex(index: i),
          );
        }
      } else if (currentTime.hour.toInt() == todayLessons[i].time.endTimeHour) {
        if (currentTime.minute.toInt() < todayLessons[i].time.endTimeMinute) {
          emit(
            ScheduleCurrentLessonIndex(index: i),
          );
        }
      }
    }
  }
}
