import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';

abstract class ScheduleRequestState extends Equatable {
  const ScheduleRequestState();

  @override
  List<Object?> get props => [];
}

class ScheduleRequestLoading extends ScheduleRequestState {
  const ScheduleRequestLoading();
}

class ScheduleInternetConnectionError extends ScheduleRequestState {
  const ScheduleInternetConnectionError();
}

class ScheduleNotFoundError extends ScheduleRequestState {
  const ScheduleNotFoundError();
}

class ScheduleUnknownError extends ScheduleRequestState {
  const ScheduleUnknownError();
}

class ScheduleRequestData extends ScheduleRequestState {
  final Schedule schedule;

  const ScheduleRequestData({required this.schedule});

  @override
  List<Object?> get props => [schedule];
}
