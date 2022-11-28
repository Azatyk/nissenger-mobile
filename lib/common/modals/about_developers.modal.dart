import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';

class AboutDevelopersModal extends StatelessWidget {
  const AboutDevelopersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Align(
            child: Image.asset(
              "assets/images/about-developers-image.png",
              width: 1.sw,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Пару слов о разработчиках",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Привет, мы разработчики Nissenger’а: Азат, Нурбек и Нурахмет. Этот и другие проекты мы делаем, потому что так мы можем вносить вклад в жизни людей через IT проекты:  делать быт наших друзей и учителей проще и комфортнее. А ещё, писать приложения это весело!",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.surface,
                    fontSize: 15.sp,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 45.h),
                CommonButton(
                  text: "Понятно",
                  reverse: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 35.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
