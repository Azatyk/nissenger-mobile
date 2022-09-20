import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(const OnboardingState(
          activeSlideIndex: 0,
        )) {
    on<NextSlideButtonClicked>(_onNextSlideButtonClicked);
  }

  void _onNextSlideButtonClicked(
    NextSlideButtonClicked event,
    Emitter<OnboardingState> emit,
  ) {
    if (!event.lastSlide) {
      emit(OnboardingState(activeSlideIndex: state.activeSlideIndex + 1));
    }
  }
}
