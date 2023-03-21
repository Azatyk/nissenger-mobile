import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/before_start_warning/view/pages/before_start_warning_page.dart';
import 'package:nissenger_mobile/modules/onboarding/data/onboarding_cubit/onboarding_cubit.dart';
import 'package:nissenger_mobile/modules/onboarding/data/onboarding_cubit/onboarding_state.dart';
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

    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        backgroundColor: theme.colorScheme.background,
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: 36.h),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: ImagesSlider(
                    controller: imagesPageViewController,
                    slides: widget.slides,
                    userType: state.userType,
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
                            builder: (context) => BeforeStartWarningPage(
                                userType: state.userType),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
