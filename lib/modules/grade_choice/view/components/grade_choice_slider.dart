import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeChoiceSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function onChanged;

  const GradeChoiceSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: theme.colorScheme.primary,
        inactiveTrackColor: theme.colorScheme.onPrimary,
        trackHeight: 8.h,
        thumbColor: theme.colorScheme.surface,
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: theme.colorScheme.surface,
        inactiveTickMarkColor: theme.colorScheme.surface,
        trackShape: CustomTrackShape(),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

// for removing default paddings
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
