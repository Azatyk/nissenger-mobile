import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/images_slider.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/onboarding_bottom.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      lazy: false,
      create: (context) => OnboardingBloc()..add(const OnboardingStarted()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              ImagesSlider(),
              // OnboardingBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
