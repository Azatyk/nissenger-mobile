import 'package:equatable/equatable.dart';

class GreetingState extends Equatable {
  const GreetingState();

  @override
  List<Object?> get props => [];
}

class GreetingPure extends GreetingState {
  const GreetingPure();
}

class GreetingReadyToPush extends GreetingState {
  final String userType;

  const GreetingReadyToPush({required this.userType});

  @override
  List<Object?> get props => [userType];
}
