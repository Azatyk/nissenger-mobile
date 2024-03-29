import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_placeholder.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/helpers/lesson_time.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_state.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_scroll_cubit/free_cabinet_schedule_scroll_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_scroll_cubit/free_cabinet_schedule_scroll_state.dart';

class FreeCabinetLessonsList extends StatefulWidget {
  final String cabinetName;
  const FreeCabinetLessonsList({
    required this.cabinetName,
    Key? key,
  }) : super(key: key);

  @override
  State<FreeCabinetLessonsList> createState() => _FreeCabinetLessonsListState();
}

class _FreeCabinetLessonsListState extends State<FreeCabinetLessonsList>
    with WidgetsBindingObserver {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    BlocProvider.of<FreeCabinetScheduleCubit>(context)
        .loadFreeCabinetSchedule(classroom: widget.cabinetName);

    controller = ScrollController();
    controller.addListener(scrollListener);

    BlocProvider.of<FreeCabinetScheduleScrollCubit>(context).reachTop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToTop();
    });

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  void scrollListener() {
    var currentState = context.read<FreeCabinetScheduleScrollCubit>().state;

    if (controller.offset > controller.position.minScrollExtent &&
        !controller.position.outOfRange &&
        currentState is FreeCabinetScheduleScrollHideBorder) {
      BlocProvider.of<FreeCabinetScheduleScrollCubit>(context, listen: false)
          .scrollToBottom();
    } else if (controller.offset <= controller.position.minScrollExtent &&
        currentState is FreeCabinetScheduleScrollShowBorder) {
      BlocProvider.of<FreeCabinetScheduleScrollCubit>(context, listen: false)
          .reachTop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      scrollToTop();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<FreeCabinetScheduleCubit, FreeCabinetScheduleState>(
      listenWhen: (prevState, newState) =>
          newState is FreeCabinetScheduleInternetConnectionError,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackbar(
            text: "Нет интернет соединения",
            theme: theme,
          ),
        );
      },
      builder: (context, state) {
        if (state is FreeCabinetScheduleLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: CircularProgressIndicator(
                  strokeWidth: 6.r,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          );
        } else if (state is FreeCabinetScheduleData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<FreeCabinetScheduleScrollCubit,
                  FreeCabinetScheduleScrollState>(
                builder: (context, state) =>
                    state is FreeCabinetScheduleScrollShowBorder
                        ? const DashedDivider()
                        : SizedBox(height: 1.h),
              ),
              Expanded(
                child: state.freeCabinetLessons.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(bottom: 30.h),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: const CommonPlaceholder(
                            text: "Для этого кабинета \nнет расписания",
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ...state.freeCabinetLessons
                                .map(
                                  (lessonData) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 5.r),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15.r),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.background,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          lessonData.name,
                                          style: theme.textTheme.labelLarge,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          LessonTimeText.time(
                                            startTimeHour:
                                                lessonData.time.startTimeHour,
                                            startTimeMinute:
                                                lessonData.time.startTimeMinute,
                                            endTimeHour:
                                                lessonData.time.endTimeHour,
                                            endTimeMinute:
                                                lessonData.time.endTimeMinute,
                                          ),
                                          style: theme.textTheme.labelMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
              ),
            ],
          );
        } else if (state is FreeCabinetScheduleInternetConnectionError ||
            state is FreeCabinetScheduleUnknownError) {
          return ErrorBlock(
            errorType: state is FreeCabinetScheduleInternetConnectionError
                ? ErrorTypes.internetConnectionError
                : ErrorTypes.unknownError,
            onMainButtonPressed: () =>
                BlocProvider.of<FreeCabinetScheduleCubit>(context)
                    .loadFreeCabinetSchedule(classroom: widget.cabinetName),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
