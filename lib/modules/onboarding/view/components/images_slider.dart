import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/skip_button.dart';

class ImagesSlider extends StatelessWidget {
  const ImagesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (prevState, newState) =>
            prevState.activeSlideIndex != newState.activeSlideIndex,
        listener: (context, state) => controller.animateToPage(
              state.activeSlideIndex,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
        builder: (context, state) {
          List<Slide> slides = state.slides;

          return Container(
            height: size.height * 0.6,
            width: double.infinity,
            color: theme.colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SkipButton(),
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: slides.length,
                  itemBuilder: (context, index) => ImageSlide(
                    imageName: slides[index].imageName,
                    size: size,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class ImageSlide extends StatelessWidget {
  final String imageName;
  final Size size;

  const ImageSlide({
    Key? key,
    required this.imageName,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset("/assets/images/onboarding/$imageName"),
      ),
    );
  }
}
