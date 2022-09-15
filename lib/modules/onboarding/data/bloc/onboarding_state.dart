import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class OnboardingState extends Equatable {
  final int activeSlideIndex;
  final List<Slide> slides;

  const OnboardingState({
    required this.activeSlideIndex,
    required this.slides,
  });

  @override
  List<Object?> get props => [activeSlideIndex, slides];

  OnboardingState copyWith({
    int? activeSlideIndex,
    List<Slide>? slides,
  }) {
    return OnboardingState(
      activeSlideIndex: activeSlideIndex ?? this.activeSlideIndex,
      slides: slides ?? this.slides,
    );
  }
}
