import 'package:equatable/equatable.dart';

abstract class ScheduleCurrentLessonState extends Equatable {
  const ScheduleCurrentLessonState();

  @override
  List<Object?> get props => [];
}

class ScheduleCurrentLessonPure extends ScheduleCurrentLessonState {
  const ScheduleCurrentLessonPure();
}

class ScheduleCurrentLessonIndex extends ScheduleCurrentLessonState {
  final int index;

  const ScheduleCurrentLessonIndex({required this.index});

  @override
  List<Object?> get props => [index];
}

class ScheduleLessonBeforeCurrentTimeoutIndex
    extends ScheduleCurrentLessonState {
  final int lessonBeforeTimeoutIndex;

  const ScheduleLessonBeforeCurrentTimeoutIndex(
      {required this.lessonBeforeTimeoutIndex});

  @override
  List<Object?> get props => [lessonBeforeTimeoutIndex];
}
