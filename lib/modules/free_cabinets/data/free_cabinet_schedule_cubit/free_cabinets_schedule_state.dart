import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';

abstract class FreeCabinetScheduleState extends Equatable {
  const FreeCabinetScheduleState();

  @override
  List<Object?> get props => [];
}

class FreeCabinetScheduleLoading extends FreeCabinetScheduleState {
  const FreeCabinetScheduleLoading();
}

class FreeCabinetScheduleInternetConnectionError
    extends FreeCabinetScheduleState {
  const FreeCabinetScheduleInternetConnectionError();
}

class FreeCabinetScheduleData extends FreeCabinetScheduleState {
  final List<Lesson> freeCabinetLessons;

  const FreeCabinetScheduleData({
    required this.freeCabinetLessons,
  });

  @override
  List<Object?> get props => [freeCabinetLessons];
}
