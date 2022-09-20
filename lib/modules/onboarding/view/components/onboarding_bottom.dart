import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_event.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/texts_slider.dart';

class OnboardingBottom extends StatelessWidget {
  final List<Slide> slides;

  const OnboardingBottom({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var state = context.watch<OnboardingBloc>().state;

    double slideIndicatorSize = 8;
    bool isLastSlide = state.activeSlideIndex == slides.length - 1;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: double.infinity,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.only(
            top: constraints.maxHeight * 0.09,
            bottom: 38,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextsSlider(
                  slides: slides,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SliderIndicator(
                        length: slides.length,
                        activeIndex: state.activeSlideIndex,
                        indicator: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: slideIndicatorSize,
                            height: slideIndicatorSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        activeIndicator: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: slideIndicatorSize,
                            height: slideIndicatorSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: CommonButton(
                      text: isLastSlide ? "Начнем" : "Далее",
                      icon: isLastSlide ? null : FontAwesomeIcons.arrowRight,
                      onPressed: () {
                        context.read<OnboardingBloc>().add(
                            NextSlideButtonClicked(lastSlide: isLastSlide));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
