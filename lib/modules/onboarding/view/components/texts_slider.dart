import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class TextsSlider extends StatelessWidget {
  const TextsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (prevState, newState) =>
            prevState.activeSlideIndex != newState.activeSlideIndex,
        listener: (context, state) => controller.animateToPage(
              state.activeSlideIndex,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
        builder: (context, state) {
          List<Slide> slides = state.slides;

          return PageView.builder(
            itemCount: slides.length,
            itemBuilder: (context, index) => TextSlide(
              title: slides[index].title,
              subtitle: slides[index].subtitle,
            ),
          );
        });
  }
}

class TextSlide extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextSlide({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: theme.textTheme.titleMedium?.copyWith(
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
