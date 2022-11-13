import 'package:equatable/equatable.dart';

class ScheduleTimeState extends Equatable {
  final bool isCurrent;

  const ScheduleTimeState({required this.isCurrent});

  @override
  List<Object?> get props => [isCurrent];
}
