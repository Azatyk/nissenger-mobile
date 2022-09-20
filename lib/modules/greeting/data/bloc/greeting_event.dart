import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class GreetingEvent extends Equatable {
  const GreetingEvent();

  @override
  List<Object?> get props => [];
}

class UserTypeChosen extends GreetingEvent {
  final String userType;
  final Completer? completer;

  const UserTypeChosen({required this.userType, this.completer});

  @override
  List<Object?> get props => [userType];
}
