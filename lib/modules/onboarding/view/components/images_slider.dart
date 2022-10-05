import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_bloc.dart';
import 'package:nissenger_mobile/modules/onboarding/data/bloc/onboarding_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/skip_button.dart';

class ImagesSlider extends StatefulWidget {
  final List<Slide> slides;

  const ImagesSlider({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    ThemeData theme = Theme.of(context);

    return BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (prevState, newState) =>
            prevState.activeSlideIndex != newState.activeSlideIndex,
        listener: (context, state) {
          if (controller.hasClients) {
            controller.animateToPage(
              state.activeSlideIndex,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
            width: double.infinity,
            color: theme.colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SkipButton(),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: widget.slides.length,
                    itemBuilder: (context, index) => ImageSlide(
                      imageName: widget.slides[index].imageName,
                    ),
                  ),
                )
              ],
            )));
  }
}

class ImageSlide extends StatelessWidget {
  final String imageName;

  const ImageSlide({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        "assets/images/onboarding/$imageName",
      ),
    );
  }
}
