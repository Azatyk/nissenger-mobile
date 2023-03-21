import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final String userType;

  const OnboardingState({
    required this.userType,
  });

  @override
  List<Object?> get props => [userType];
}
