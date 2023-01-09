import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_state.dart';

class FreeCabinetLessonsList extends StatelessWidget {
  final bool isFree = true;

  const FreeCabinetLessonsList({
    Key? key,
  }) : super(key: key);

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
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Расписание кабинета на сегодня:",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      children: state.freeCabinetLessons
                          .map(
                            (lessonData) => Container(
                              decoration: BoxDecoration(
                                color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    lessonData.name,
                                    style: theme.textTheme.labelMedium,
                                  ),
                                  Text(
                                    "${lessonData.time.startTimeHour.toString().padLeft(2, "0")}:${lessonData.time.startTimeMinute.toString().padLeft(2, "0")} — ${lessonData.time.endTimeHour.toString().padLeft(2, "0")}:${lessonData.time.endTimeMinute.toString().padLeft(2, "0")}",
                                    style: theme.textTheme.labelLarge,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
