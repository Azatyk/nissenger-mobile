import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/images_slider.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/onboarding_bottom.dart';

class OnboardingPage extends StatelessWidget {
  final List<Slide> slides;

  const OnboardingPage({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      lazy: false,
      create: (context) => OnboardingBloc(),
      child: OnboardingPageContent(
        slides: slides,
      ),
    );
  }
}

class OnboardingPageContent extends StatelessWidget {
  final List<Slide> slides;

  const OnboardingPageContent({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 38),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ImagesSlider(
                slides: slides,
              ),
            ),
            Expanded(
              flex: 4,
              child: OnboardingBottom(
                slides: slides,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
