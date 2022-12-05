import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeforeStartText extends StatelessWidget {
  const BeforeStartText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Перед тем как начнем",
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
        SizedBox(height: 22.h),
        const BeforeStartDescription(
            text:
                "1) Это бета версия приложения, а значит вы можете столкнуться с багами и ошибками. Давайте договоримся: с вас сообщение в тех поддержку, а с нас быстрое исправление этих проблем."),
        SizedBox(height: 30.h),
        const BeforeStartDescription(
            text:
                "2) Мы получаем все данные с сайта школьного расписания «fmalmnis.edupage.org», поэтому неправильные имена, расписания и группы дублируются с сайта."),
        SizedBox(height: 20.h),
        const BeforeStartDescription(
            text:
                "Если вы нашли ошибку в данных, пожалуйста, напишите в тех поддержку и мы передадим администрации."),
      ],
    );
  }
}

class BeforeStartDescription extends StatelessWidget {
  final String text;

  const BeforeStartDescription({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.surface,
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
    );
  }
}
