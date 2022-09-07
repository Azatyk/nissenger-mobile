import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/greeting/bloc/greeting_enums.dart';

abstract class GreetingEvent extends Equatable {
  const GreetingEvent();

  @override
  List<Object?> get props => [];
}

class UserTypeChosen extends GreetingEvent {
  final UserTypes userType;

  const UserTypeChosen({required this.userType});

  @override
  List<Object?> get props => [userType];
}
