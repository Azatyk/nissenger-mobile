import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/greeting/data/cubit/greeting_cubit.dart';
import 'package:nissenger_mobile/modules/greeting/data/cubit/greeting_state.dart';
import 'package:nissenger_mobile/modules/onboarding/data/plain_data/slides.dart';
import 'package:nissenger_mobile/modules/onboarding/data/types/slide.dart';
import 'package:nissenger_mobile/modules/onboarding/view/pages/onboarding_page.dart';
import 'package:url_launcher/url_launcher.dart';

class GreetingActions extends StatelessWidget {
  const GreetingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<GreetingCubit, GreetingState>(
      listenWhen: (prevState, newState) => newState is GreetingReadyToPush,
      listener: (context, state) {
        List<Slide> slides = [];

        if ((state as GreetingReadyToPush).userType == UserTypes.teacher) {
          slides = SlidesData.teacherSlides;
        } else if (state.userType == UserTypes.student) {
          slides = SlidesData.studentSlides;
        }

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OnboardingPage(slides: slides),
        ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              // ignore: deprecated_member_use
              await launch("https://nissenger.com");
            },
            child: Text(
              LangKeys.proceedPrivacyPolicy.translate(context),
              style: theme.textTheme.labelLarge?.copyWith(
                decoration: TextDecoration.underline,
                color: const Color(0xFFE0E0E0),
                height: 1.4,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          CommonButton(
            text: LangKeys.iAmTeacher.translate(context),
            reverse: true,
            onPressed: () {
              context
                  .read<GreetingCubit>()
                  .chooseUserType(userType: UserTypes.teacher);
            },
          ),
          SizedBox(height: 10.h),
          CommonButton(
            text: LangKeys.iAmStudent.translate(context),
            reverse: true,
            onPressed: () {
              context
                  .read<GreetingCubit>()
                  .chooseUserType(userType: UserTypes.student);
            },
          ),
        ],
      ),
    );
  }
}
