import "package:flutter/material.dart";
import 'package:nissenger_mobile/modules/onboarding/view/components/texts_slider.dart';

class OnboardingBottom extends StatelessWidget {
  const OnboardingBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextsSlider(),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              // children: [

              // ],
            ),
          )
        ],
      ),
    );
  }
}
