import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_day_cubit/schedule_day_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_state.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_scroll_cubit/schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/schedule_day.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/components/schedule_header.dart';

class ScheduleLessons extends StatefulWidget {
  const ScheduleLessons({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleLessons> createState() => _ScheduleLessonsState();
}

class _ScheduleLessonsState extends State<ScheduleLessons> {
  late int activePageIndex;
  late PageController controller;

  @override
  void initState() {
    DateTime today = DateTime.now();

    switch (today.weekday) {
      case DateTime.monday:
        activePageIndex = 0;
        break;
      case DateTime.tuesday:
        activePageIndex = 1;
        break;
      case DateTime.wednesday:
        activePageIndex = 2;
        break;
      case DateTime.thursday:
        activePageIndex = 3;
        break;
      case DateTime.friday:
        activePageIndex = 4;
        break;
      case DateTime.saturday:
        activePageIndex = 5;
        break;
      case DateTime.sunday:
        activePageIndex = 0;
        break;
    }

    controller = PageController(initialPage: activePageIndex);

    super.initState();
  }

  void navigateToPage() {
    controller.animateToPage(
      activePageIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<ScheduleRequestCubit, ScheduleRequestState>(
        builder: (context, state) {
      if (state is ScheduleRequestLoading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: SizedBox(
              width: 40.r,
              height: 40.r,
              child: CircularProgressIndicator(
                strokeWidth: 4.w,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        );
      } else if (state is ScheduleRequestData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) => ScheduleScrollCubit(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: ScheduleHeader(
                  activeDayIndex: activePageIndex,
                  onBackButtonClicked: () {
                    setState(() {
                      activePageIndex--;
                    });
                    navigateToPage();
                    BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                      index: activePageIndex,
                    );
                  },
                  onNextButtonClicked: () {
                    setState(() {
                      activePageIndex++;
                    });
                    navigateToPage();
                    BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                      index: activePageIndex,
                    );
                  },
                ),
              ),
            ),
            Flexible(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    activePageIndex = index;
                  });
                  BlocProvider.of<ScheduleDayCubit>(context).getDayTitle(
                    index: activePageIndex,
                  );
                },
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: state.schedule.days.length,
                itemBuilder: (context, index) => BlocProvider(
                  create: (context) => ScheduleScrollCubit(),
                  child: ScheduleDay(
                    dayLessons: state.schedule.days[index],
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
