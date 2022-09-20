import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class TextsSlider extends StatefulWidget {
  final List<Slide> slides;

  const TextsSlider({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<TextsSlider> createState() => _TextsSliderState();
}

class _TextsSliderState extends State<TextsSlider> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (prevState, newState) =>
            prevState.activeSlideIndex != newState.activeSlideIndex,
        listener: (context, state) {
          if (controller.hasClients) {
            controller.animateToPage(
              state.activeSlideIndex,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          }
        },
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: widget.slides.length,
          itemBuilder: (context, index) => TextSlide(
            title: widget.slides[index].title,
            subtitle: widget.slides[index].subtitle,
          ),
        ));
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
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
