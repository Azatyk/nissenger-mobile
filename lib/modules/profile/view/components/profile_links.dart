import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/common/modals/about_schedule.modal.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_cubit.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';
import 'package:nissenger_mobile/modules/profile/view/components/profile_link.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/pages/teachers_choice_page.dart';

class ProfileLinks extends StatelessWidget {
  const ProfileLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStudent =
        (BlocProvider.of<ProfileDataCubit>(context).state as ProfileData)
                .userType ==
            UserTypes.student;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Title(text: "Основное"),
            SizedBox(height: 16.h),
            ProfileLink(
              icon: FontAwesomeIcons.rotate,
              text: isStudent ? "Другой класс" : "Другой учитель",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => isStudent
                        ? const GradeChoicePage()
                        : const TeachersChoicePage(),
                  ),
                );
                BlocProvider.of<ProfileDataCubit>(context).logout();
                BlocProvider.of<ProfileDataCubit>(context).setUserType(
                  userType: isStudent ? UserTypes.student : UserTypes.teacher,
                );
              },
            ),
            if (isStudent)
              ProfileLink(
                icon: FontAwesomeIcons.masksTheater,
                text: "Поменять группу",
                onPressed: () {
                  int currentGroup = (BlocProvider.of<ProfileDataCubit>(context)
                              .state as ProfileData)
                          .gradeGroup ??
                      0;
                  int newGroup = currentGroup == 1
                      ? 2
                      : currentGroup == 2
                          ? 1
                          : 0;

                  BlocProvider.of<ProfileDataCubit>(context)
                      .changeGradeGroup(newGroup: newGroup);

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SchedulePage()),
                    (route) => false,
                  );
                },
              ),
            ProfileLink(
              icon: FontAwesomeIcons.circleQuestion,
              text: "Связаться с нами",
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                      20.r,
                    )),
                  ),
                  context: context,
                  builder: (context) => const SupportMethodsModal(),
                );
              },
            ),
            SizedBox(height: 20.h),
            const Title(text: "О приложении"),
            SizedBox(height: 16.h),
            ProfileLink(
              icon: FontAwesomeIcons.userTie,
              text: "Политика конфиденциальности",
              onPressed: () {},
            ),
            ProfileLink(
              icon: FontAwesomeIcons.mobileScreen,
              text: "Кто написал приложение?",
              onPressed: () {},
            ),
            ProfileLink(
              icon: FontAwesomeIcons.table,
              text: "О расписании",
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                      20.r,
                    )),
                  ),
                  context: context,
                  builder: (context) => const AboutScheduleModal(),
                );
              },
            ),
          ],
        ),
        ProfileLink(
          icon: FontAwesomeIcons.rightFromBracket,
          text: "Выйти",
          logout: true,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const GreetingPage(),
              ),
              (route) => false,
            );
            BlocProvider.of<ProfileDataCubit>(context).logout();
          },
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final String text;

  const Title({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}