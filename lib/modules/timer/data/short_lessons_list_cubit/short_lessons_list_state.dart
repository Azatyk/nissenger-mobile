import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/lesson_time.model.dart';
import 'package:nissenger_mobile/modules/timer/data/types/short_lessons_list_types.dart';

class ShortLessonsListState extends Equatable {
  const ShortLessonsListState();

  @override
  List<Object?> get props => [];
}

class ShortLessonsListRequestLoading extends ShortLessonsListState {
  const ShortLessonsListRequestLoading();
}

class ShortLessonsListRequestError extends ShortLessonsListState {
  const ShortLessonsListRequestError();
}

class ShortLessonsListData extends ShortLessonsListState {
  final List<Lesson> threeLessons;
  final int numberOfRemainedLessons;
  final LessonTime lastLessonEndTime;
  final ShortLessonsListTypes type;
  final int activeLessonIndex;
  final bool isTimeout;

  const ShortLessonsListData({
    required this.threeLessons,
    required this.numberOfRemainedLessons,
    required this.lastLessonEndTime,
    required this.type,
    required this.activeLessonIndex,
    this.isTimeout = false,
  });

  @override
  List<Object?> get props => [
        threeLessons,
        numberOfRemainedLessons,
        lastLessonEndTime,
        type,
        activeLessonIndex,
        isTimeout,
      ];
}
