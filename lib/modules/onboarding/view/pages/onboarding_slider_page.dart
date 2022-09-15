import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';

class OnboardingSliderPage extends StatelessWidget {
  const OnboardingSliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider<OnboardingBloc>(
      lazy: false,
      create: (context) => OnboardingBloc()..add(const OnboardingStarted()),
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
      ),
    );
  }
}
