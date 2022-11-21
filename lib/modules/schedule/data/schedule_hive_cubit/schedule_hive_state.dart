import 'package:equatable/equatable.dart';

class ScheduleHiveState extends Equatable {
  final String userType;

  const ScheduleHiveState({required this.userType});

  @override
  List<Object?> get props => [userType];
}
