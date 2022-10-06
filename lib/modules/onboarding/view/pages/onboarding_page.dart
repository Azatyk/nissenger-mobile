import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/images_slider.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/onboarding_bottom.dart';

class OnboardingPage extends StatefulWidget {
  final List<Slide> slides;

  const OnboardingPage({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int activeSlideIndex = 0;
  PageController imagesPageViewController = PageController(initialPage: 0);
  PageController textsPageViewController = PageController(initialPage: 0);

  void _slidePageView() {
    setState(() {
      activeSlideIndex++;
    });

    Duration animationDuration = const Duration(milliseconds: 250);
    Cubic animationCurve = Curves.easeInOut;

    imagesPageViewController.animateToPage(
      activeSlideIndex,
      duration: animationDuration,
      curve: animationCurve,
    );

    textsPageViewController.animateToPage(
      activeSlideIndex,
      duration: animationDuration,
      curve: animationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 36.h),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ImagesSlider(
                controller: imagesPageViewController,
                slides: widget.slides,
              ),
            ),
            Expanded(
              flex: 4,
              child: OnboardingBottom(
                textsPageViewController: textsPageViewController,
                activeSlideIndex: activeSlideIndex,
                slides: widget.slides,
                isLastSlide: activeSlideIndex == widget.slides.length - 1,
                onPressed: () {
                  if (activeSlideIndex != widget.slides.length - 1) {
                    _slidePageView();
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GradeChoicePage(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
