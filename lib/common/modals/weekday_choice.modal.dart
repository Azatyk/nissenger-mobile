import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_weekday.dart';
import 'package:nissenger_mobile/data/plain_data/weekdays.data.dart';

class WeekdayChoiceModal extends StatelessWidget {
  final int activeWeekdayIndex;
  final Function({required int index}) changeWeekday;

  const WeekdayChoiceModal({
    Key? key,
    required this.activeWeekdayIndex,
    required this.changeWeekday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 30.h),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CommonWeekday(
              text: WeekdaysData.weekdays[index].uiTitle,
              active: activeWeekdayIndex == index,
              onPressed: () {
                changeWeekday(index: index);
                Navigator.of(context).pop();
              },
            ),
          ),
          itemCount: WeekdaysData.weekdays.length,
        ));
  }
}
