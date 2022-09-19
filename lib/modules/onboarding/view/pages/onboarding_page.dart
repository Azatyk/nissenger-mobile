import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/images_slider.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/loading_indicator.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/onboarding_bottom.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Start of building");
    return BlocProvider<OnboardingBloc>(
      lazy: false,
      create: (context) => OnboardingBloc()..add(const OnboardingStarted()),
      child: const OnboardingPageContent(),
    );
  }
}

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Start of building child");
    ThemeData theme = Theme.of(context);

    return BlocBuilder<OnboardingBloc, OnboardingState>(
        buildWhen: (prevState, newState) => prevState.slides != newState.slides,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: Padding(
              padding: const EdgeInsets.only(top: 38),
              child: Column(
                children: const [
                  Expanded(
                    flex: 7,
                    child: ImagesSlider(),
                  ),
                  Expanded(
                    flex: 4,
                    child: OnboardingBottom(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
