import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
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
          return Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Center(
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
          return Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHeader(
                  title: "${widget.cabinetName} кабинет",
                ),
                SizedBox(height: 10.h),
                Text(
                  "Расписание кабинета на сегодня:",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 20.h),
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
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.boxOpen,
                                  color: theme.colorScheme.primary,
                                  size: 36.sp,
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  "Для этого кабинета \nнет расписания",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          controller: controller,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: state.freeCabinetLessons
                                .map(
                                  (lessonData) => Container(
                                    margin: EdgeInsets.all(5.r),
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
                                          "${lessonData.time.startTimeHour.toString().padLeft(2, "0")}:${lessonData.time.startTimeMinute.toString().padLeft(2, "0")} — ${lessonData.time.endTimeHour.toString().padLeft(2, "0")}:${lessonData.time.endTimeMinute.toString().padLeft(2, "0")}",
                                          style: theme.textTheme.labelMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}