import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/helpers/index_to_letter_map.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_state.dart';

class GradeLetterChoiceSlider extends StatelessWidget {
  final Function({required String gradeLetter}) onChanged;

  const GradeLetterChoiceSlider({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<GradeChoiceFormCubit, GradeChoiceFormState>(
              builder: (context, state) => Text(
                state.gradeLetter,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: 40.sp,
                  height: 1,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Text(
                "буква класса",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SliderTheme(
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
            child: BlocBuilder<GradeChoiceFormCubit, GradeChoiceFormState>(
              builder: (context, state) => Slider(
                value:
                    mapGradeLetterToIndex(letter: state.gradeLetter).toDouble(),
                min: 0,
                max: 7,
                divisions: 7,
                onChanged: (value) {
                  String gradeLetterValue =
                      mapIndexToGradeLetter(index: value.toInt());

                  BlocProvider.of<GradeChoiceFormCubit>(context)
                      .changeGradeLetter(
                    gradeLetter: gradeLetterValue,
                  );

                  onChanged(gradeLetter: gradeLetterValue);
                },
              ),
            ),
          ),
        ),
      ],
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
