import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';

class SecondSchedulePageButtonModal extends StatelessWidget {
  final String userType;

  const SecondSchedulePageButtonModal({
    Key? key,
    required this.userType,
  }) : super(key: key);

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
            userType == UserTypes.student
                ? "Расписание соров"
                : userType == UserTypes.teacher
                    ? "Свободный кабинет"
                    : "",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            userType == UserTypes.student
                ? "Показываем когда и по каким предметам у тебя соры и уведомляем заранее, чтобы можно было подготовиться. Раздел в разработке."
                : userType == UserTypes.teacher
                    ? "Находите свободный кабинет для дополнительных уроков или просто, чтобы посидеть. Раздел в разработке."
                    : "",
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
          SizedBox(height: 35.h),
        ],
      ),
    );
  }
}
