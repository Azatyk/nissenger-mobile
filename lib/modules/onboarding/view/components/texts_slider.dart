import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';

class TextsSlider extends StatelessWidget {
  final PageController controller;
  final List<Slide> slides;

  const TextsSlider({
    Key? key,
    required this.controller,
    required this.slides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      itemCount: slides.length,
      itemBuilder: (context, index) => TextSlide(
        title: slides[index].title,
        subtitle: slides[index].subtitle,
      ),
    );
  }
}

class TextSlide extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextSlide({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              subtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
