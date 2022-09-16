import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/texts_slider.dart';

class OnboardingBottom extends StatelessWidget {
  const OnboardingBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var state = context.watch<OnboardingBloc>().state;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: double.infinity,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.only(top: constraints.maxHeight * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: TextsSlider(),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SliderIndicator(
                        length: state.slides.length,
                        activeIndex: state.activeSlideIndex,
                        indicator: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        activeIndicator: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: 20,
                          height: 10,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        )),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: CommonButton(
                        text: state.slides[state.activeSlideIndex].lastSlide
                            ? "Начнем"
                            : "Далее",
                        icon: !state.slides[state.activeSlideIndex].lastSlide
                            ? FontAwesomeIcons.arrowRight
                            : null,
                        onPressed: () {
                          context
                              .read<OnboardingBloc>()
                              .add(const NextSlideButtonClicked());
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
