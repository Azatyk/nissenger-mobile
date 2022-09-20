import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class NextSlideButtonClicked extends OnboardingEvent {
  final bool lastSlide;

  const NextSlideButtonClicked({
    required this.lastSlide,
  });

  @override
  List<Object?> get props => [lastSlide];
}
