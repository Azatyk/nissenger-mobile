import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/onboarding/data/plain_data/slides.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/components/skip_button.dart';

class ImagesSlider extends StatelessWidget {
  final PageController controller;
  final List<Slide> slides;

  const ImagesSlider({
    Key? key,
    required this.controller,
    required this.slides,
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
            SkipButton(
              slides: slides == SlidesData.studentSlides,
            ),
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
        width: 0.7.sw,
      ),
    );
  }
}
