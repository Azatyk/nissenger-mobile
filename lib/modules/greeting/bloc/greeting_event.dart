import 'package:equatable/equatable.dart';

abstract class GreetingEvent extends Equatable {
  const GreetingEvent();

  @override
  List<Object?> get props => [];
}

class UserTypeChosen extends GreetingEvent {
  final String userType;

  const UserTypeChosen({required this.userType});

  @override
  List<Object?> get props => [userType];
}
