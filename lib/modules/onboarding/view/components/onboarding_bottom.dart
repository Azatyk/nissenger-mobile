import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/texts_slider.dart';

class OnboardingBottom extends StatelessWidget {
  final PageController textsPageViewController;
  final int activeSlideIndex;
  final List<Slide> slides;
  final bool isLastSlide;
  final VoidCallback onPressed;

  const OnboardingBottom({
    Key? key,
    required this.textsPageViewController,
    required this.slides,
    required this.isLastSlide,
    required this.onPressed,
    required this.activeSlideIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double slideIndicatorSize = 8.r;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: double.infinity,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.only(
            top: 26.h,
            bottom:
                defaultTargetPlatform == TargetPlatform.android ? 20.h : 38.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextsSlider(
                  controller: textsPageViewController,
                  slides: slides,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: SliderIndicator(
                        length: slides.length,
                        activeIndex: activeSlideIndex,
                        indicator: Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Container(
                            width: slideIndicatorSize,
                            height: slideIndicatorSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                        ),
                        activeIndicator: Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Container(
                            width: slideIndicatorSize,
                            height: slideIndicatorSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 18.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: CommonButton(
                      text: isLastSlide ? "Начнем" : "Далее",
                      icon: isLastSlide ? null : FontAwesomeIcons.arrowRight,
                      onPressed: onPressed,
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
