import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int activeSlideIndex;

  const OnboardingState({
    required this.activeSlideIndex,
  });

  @override
  List<Object?> get props => [activeSlideIndex];
}
