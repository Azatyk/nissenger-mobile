import "package:flutter/material.dart";
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/skip_button.dart';

class ImagesSlider extends StatelessWidget {
  final PageController controller;
  final List<Slide> slides;
  final Function skipButton;

  const ImagesSlider({
    Key? key,
    required this.controller,
    required this.slides,
    required this.skipButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
        width: double.infinity,
        color: theme.colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SkipButton(skip: skipButton),
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                itemCount: slides.length,
                itemBuilder: (context, index) => ImageSlide(
                  imageName: slides[index].imageName,
                ),
              ),
            )
          ],
        ));
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
