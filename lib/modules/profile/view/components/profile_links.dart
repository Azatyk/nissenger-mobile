import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/about_developers.modal.dart';
import 'package:nissenger_mobile/common/modals/about_app.modal.dart';
import 'package:nissenger_mobile/common/modals/change_group.modal.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
import 'package:nissenger_mobile/common/modals/warning.modal.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/pages/grade_choice_page.dart';
import 'package:nissenger_mobile/modules/presets/view/pages/presets_page.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_cubit.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';
import 'package:nissenger_mobile/modules/profile/view/components/profile_link.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/pages/teachers_choice_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLinks extends StatelessWidget {
  const ProfileLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStudent =
        (BlocProvider.of<ProfileDataCubit>(context).state as ProfileData)
                .userType ==
            UserTypes.student;

    void changeGroup() {
      Navigator.of(context).pop();

      int currentGroup =
          (BlocProvider.of<ProfileDataCubit>(context).state as ProfileData)
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
        MaterialPageRoute(builder: (context) => const SchedulePage()),
        (route) => false,
      );
    }

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
              text: "К пресетам",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PresetsPage(),
                  ),
                );
              },
            ),
            if (isStudent)
              ProfileLink(
                icon: FontAwesomeIcons.masksTheater,
                text: "Поменять группу",
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
                    builder: (context) => ChangeGroupModal(
                      onButtonPressed: () {
                        changeGroup();
                      },
                    ),
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
                  builder: (context) => BlocProvider(
                    create: (context) => SupportCubit(),
                    child: const SupportMethodsModal(),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            const Title(text: "О приложении"),
            SizedBox(height: 16.h),
            ProfileLink(
              icon: FontAwesomeIcons.instagram,
              text: "Наш Instagram",
              onPressed: () async {
                // ignore: deprecated_member_use
                await launch("https://www.instagram.com/nissenger.app/");
              },
            ),
            ProfileLink(
              icon: FontAwesomeIcons.mobileScreen,
              text: "Кто написал приложение?",
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const AboutDevelopersModal(),
                );
              },
            ),
            ProfileLink(
              icon: FontAwesomeIcons.table,
              text: "О приложении",
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
                  builder: (context) => const AboutAppModal(),
                );
              },
            ),
            ProfileLink(
              icon: FontAwesomeIcons.userTie,
              text: "Политика конфиденциальности",
              onPressed: () async {
                // ignore: deprecated_member_use
                await launch("https://nissenger.com");
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: ProfileLink(
            icon: FontAwesomeIcons.rightFromBracket,
            text: "Выйти",
            logout: true,
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
                builder: (context) => BlocProvider(
                  create: (context) => ProfileDataCubit(),
                  child: const Warning(),
                ),
              );
            },
          ),
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
