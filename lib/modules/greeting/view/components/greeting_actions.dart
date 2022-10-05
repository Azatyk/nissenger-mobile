import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_bloc.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_event.dart';
import 'package:nissenger_mobile/common/types/user_types.dart';
import 'package:nissenger_mobile/modules/onboarding/data/plain_data/slides.dart';
import 'package:nissenger_mobile/modules/onboarding/view/pages/onboarding_page.dart';

class GreetingActions extends StatelessWidget {
  const GreetingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Продолжая, вы принимаете\nполитику конфиденциальности и\nпользовательское соглашение",
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFFE0E0E0),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        CommonButton(
          text: "Я учитель",
          reverse: true,
          onPressed: () {
            final completer = Completer();

            BlocProvider.of<GreetingBloc>(context).add(
              UserTypeChosen(
                userType: UserTypes.teacher,
                completer: completer,
              ),
            );

            completer.future.then((_) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OnboardingPage(
                    slides: SlidesData.teacherSlides,
                  ),
                ),
              );
            });
          },
        ),
        SizedBox(height: 10.h),
        CommonButton(
          text: "Я ученик",
          reverse: true,
          onPressed: () {
            final completer = Completer();

            BlocProvider.of<GreetingBloc>(context).add(
              UserTypeChosen(
                userType: UserTypes.student,
                completer: completer,
              ),
            );
            completer.future.then((_) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(
                      slides: SlidesData.studentSlides,
                    ),
                  ),
                ));
          },
        ),
      ],
    );
  }
}
