import 'package:equatable/equatable.dart';

class ScheduleDayState extends Equatable {
  const ScheduleDayState();

  @override
  List<Object?> get props => [];
}

class ScheduleDayPure extends ScheduleDayState {
  const ScheduleDayPure();
}

class ScheduleDayTitle extends ScheduleDayState {
  final String dayTitle;

  const ScheduleDayTitle({required this.dayTitle});

  @override
  List<Object?> get props => [dayTitle];
}
