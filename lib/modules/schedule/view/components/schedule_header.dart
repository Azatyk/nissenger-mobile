import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_day_cubit/schedule_day_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_day_cubit/schedule_day_state.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_scroll_cubit/schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_scroll_cubit/schedule_scroll_state.dart';
import 'package:nissenger_mobile/modules/schedule/view/components/schedule_header_button.dart';

class ScheduleHeader extends StatefulWidget {
  final int activeDayIndex;
  final VoidCallback onBackButtonClicked;
  final VoidCallback onNextButtonClicked;

  const ScheduleHeader({
    Key? key,
    required this.activeDayIndex,
    required this.onBackButtonClicked,
    required this.onNextButtonClicked,
  }) : super(key: key);

  @override
  State<ScheduleHeader> createState() => _ScheduleHeaderState();
}

class _ScheduleHeaderState extends State<ScheduleHeader> {
  @override
  void initState() {
    BlocProvider.of<ScheduleDayCubit>(context)
        .getDayTitle(index: widget.activeDayIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<ScheduleDayCubit, ScheduleDayState>(
      builder: (context, state) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScheduleHeaderButton(
                icon: FontAwesomeIcons.arrowLeft,
                onClicked: widget.onBackButtonClicked,
                active: widget.activeDayIndex != 0,
              ),
              if (state is ScheduleDayTitle)
                Text(
                  state.dayTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
              ScheduleHeaderButton(
                icon: FontAwesomeIcons.arrowRight,
                onClicked: widget.onNextButtonClicked,
                active: widget.activeDayIndex != 5,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          BlocBuilder<ScheduleScrollCubit, ScheduleScrollState>(
              builder: (context, state) {
            return state is ScheduleScrollShowBorder
                ? const DashedDivider()
                : const SizedBox(height: 1);
          }),
        ],
      ),
    );
  }
}
