import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/types/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/plain_data/slides.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(const OnboardingState(
          activeSlideIndex: 0,
          slides: [],
        )) {
    on<OnboardingStarted>(_onOnboardingStarted);
    on<NextSlideButtonClicked>(_onNextSlideButtonClicked);
  }

  late String userType;

  void _onOnboardingStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) {
    var box = Hive.box(HiveBoxes.userSettingsBox);
    userType = box.get("type");

    List<Slide> activeSlides;

    if (userType == UserTypes.student) {
      activeSlides = SlidesData.studentSlides;
    } else {
      activeSlides = SlidesData.teacherSlides;
    }

    emit(
      state.copyWith(slides: activeSlides),
    );
  }

  void _onNextSlideButtonClicked(
    NextSlideButtonClicked event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.activeSlideIndex != state.slides.length - 1) {
      emit(state.copyWith(activeSlideIndex: state.activeSlideIndex + 1));
    }
  }
}
