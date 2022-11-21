import 'package:equatable/equatable.dart';

class ScheduleUserTypeState extends Equatable {
  final String userType;

  const ScheduleUserTypeState({required this.userType});

  @override
  List<Object?> get props => [userType];
}
