import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/day.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/scedule_status.dart';

class ScheduleRequestState extends Equatable {
  final ScheduleStatus status;
  final List<Day> listOfDays;

  const ScheduleRequestState({required this.status, required this.listOfDays});

  @override
  List<Object?> get props => [status];
}
