import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';

class FreeCabinetModal extends StatelessWidget {
  final String cabinetName;
  final bool isFree;
  final int lessonsLeft;

  const FreeCabinetModal(
      {required this.cabinetName,
      required this.isFree,
      required this.lessonsLeft,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                  lessonsLeft > 1
                      ? "По расписанию кабинет будет свободен еще $lessonsLeft урока"
                      : "По расписанию кабинет будет свободен еще $lessonsLeft урок",
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
            height:
                defaultTargetPlatform == TargetPlatform.android ? 35.h : 50.h,
          ),
        ],
      ),
    );
  }
}
