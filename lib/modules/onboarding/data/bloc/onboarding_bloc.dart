import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/user_types.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/plain_data/slides.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(const OnboardingState(
          title: "",
          subtitle: "",
          imageName: "",
          lastSlide: false,
        )) {
    on<OnboardingStarted>(_onOnboardingStarted);
    on<NextSlideButtonClicked>(_onNextSlideButtonClicked);
  }

  int activeSlideIndex = 0;
  late String userType;

  void _onOnboardingStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) {
    var box = Hive.box(HiveBoxes.userSettingsBox);
    userType = box.get("type");

    Slide activeSlide;

    if (userType == UserTypes.student) {
      activeSlide = SlidesData.studentSlides[activeSlideIndex];
    } else {
      activeSlide = SlidesData.teacherSlides[activeSlideIndex];
    }

    emit(OnboardingState(
      title: activeSlide.title,
      subtitle: activeSlide.subtitle,
      imageName: activeSlide.imageName,
      lastSlide: activeSlide.lastSlide,
    ));
  }

  void _onNextSlideButtonClicked(
    NextSlideButtonClicked event,
    Emitter<OnboardingState> emit,
  ) {
    if (!state.lastSlide) {
      activeSlideIndex++;
      Slide nextSlide;

      if (userType == UserTypes.student) {
        nextSlide = SlidesData.studentSlides[activeSlideIndex];
      } else {
        nextSlide = SlidesData.teacherSlides[activeSlideIndex];
      }

      emit(OnboardingState(
        title: nextSlide.title,
        subtitle: nextSlide.subtitle,
        imageName: nextSlide.imageName,
        lastSlide: nextSlide.lastSlide,
      ));
    }
  }
}
