import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_cubit.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_cubit/free_cabinets_schedule_state.dart';

class FreeCabinetModal extends StatelessWidget {
  final String cabinetName;
  final bool isFree = true;

  const FreeCabinetModal({
    required this.cabinetName,
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  "$cabinetName кабинет",
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 26.sp),
                ),
                SizedBox(height: 16.h),
                isFree
                    ? Text(
                        "Свободен",
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color.fromRGBO(25, 161, 89, 1),
                            fontSize: 18.sp),
                      )
                    : Text(
                        "Занят",
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color.fromRGBO(231, 76, 60, 1),
                            fontSize: 18.sp),
                      ),
                SizedBox(height: 16.h),
                isFree
                    ? Text(
                        state.freeCabinetLessons.length > 1
                            ? "По расписанию кабинет будет свободен еще ${state.freeCabinetLessons.length} урока"
                            : "По расписанию кабинет будет свободен еще ${state.freeCabinetLessons.length} урок",
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 16.sp,
                          height: 1.6,
                        ),
                      )
                    : Text(
                        "По расписанию кабинет закрыт",
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 15.sp,
                          height: 1.6,
                        ),
                      ),
                SizedBox(height: 45.h),
                CommonButton(
                  text: "Понятно",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: defaultTargetPlatform == TargetPlatform.android
                      ? 35.h
                      : 50.h,
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
