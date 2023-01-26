import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SauDay extends StatelessWidget {
  final String day;
  final String date;
  final List<String> sauList;
  final int index;
  final bool isToday;

  const SauDay({
    required this.index,
    required this.day,
    required this.date,
    required this.sauList,
    required this.isToday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
        right: 14.w,
        bottom: 18.h,
      ),
      decoration: BoxDecoration(
        color: isToday
            ? theme.colorScheme.background
            : theme.colorScheme.onPrimary,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                day,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                date,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          sauList.isEmpty
              ? Text(
                  "В этот день нет соров",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 15.sp,
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Column(
                  children: List.generate(
                    sauList.length,
                    (index) {
                      return Text(
                        "${index.toString()}. ${sauList[index]}",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
