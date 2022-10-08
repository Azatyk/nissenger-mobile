import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_state.dart';

class GradeNumberChoiceSlider extends StatelessWidget {
  const GradeNumberChoiceSlider({
    Key? key,
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
                state.gradeNumber.toString(),
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: 40.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                "номер класса",
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
                value: state.gradeNumber.toDouble(),
                min: 7,
                max: 12,
                divisions: 5,
                onChanged: (value) {
                  BlocProvider.of<GradeChoiceFormCubit>(context)
                      .changeGradeNumber(gradeNumber: value.toInt());
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
