import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/timer/data/types/short_lessons_list_types.dart';

class ShortLessonsListState extends Equatable {
  const ShortLessonsListState();

  @override
  List<Object?> get props => [];
}

class ShortLessonsListRequestLoading extends ShortLessonsListState {
  const ShortLessonsListRequestLoading();
}

class ShortLessonsListInternetConnectionError extends ShortLessonsListState {
  const ShortLessonsListInternetConnectionError();
}

class ShortLessonsListUnknownError extends ShortLessonsListState {
  const ShortLessonsListUnknownError();
}

class ShortLessonsListRequestData extends ShortLessonsListState {
  final Schedule schedule;

  const ShortLessonsListRequestData({required this.schedule});

  @override
  List<Object?> get props => [schedule];
}

class ShortLessonsListData extends ShortLessonsListState {
  final List<Lesson> threeLessons;
  final int numberOfRemainedLessons;
  final LessonTime lastLessonEndTime;
  final ShortLessonsListTypes type;
  final int activeLessonIndex;
  final bool isTimeout;
  final bool titleMonday;

  const ShortLessonsListData({
    required this.threeLessons,
    required this.numberOfRemainedLessons,
    required this.lastLessonEndTime,
    required this.type,
    required this.activeLessonIndex,
    this.isTimeout = false,
    this.titleMonday = false,
  });

  @override
  List<Object?> get props => [
        threeLessons,
        numberOfRemainedLessons,
        lastLessonEndTime,
        type,
        activeLessonIndex,
        isTimeout,
        titleMonday,
      ];
}
