import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SauDay extends StatelessWidget {
  final String day;
  final String date;
  final List<String> sauList;
  final bool isToday;

  const SauDay({
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
        left: 14.w,
        bottom: 18.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: isToday
            ? theme.colorScheme.onSurface
            : theme.colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "$day,",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                width: 10.w,
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
          SizedBox(
            height: 14.h,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    sauList.length,
                    (index) {
                      int indexNew = index + 1;
                      return Column(
                        children: [
                          Text(
                            "${indexNew.toString()}. ${sauList[index]}",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: sauList.length == index + 1 ? 0.h : 5.h,
                          )
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
