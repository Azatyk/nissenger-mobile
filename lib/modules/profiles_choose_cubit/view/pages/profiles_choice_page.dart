import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/profiles_choice_page_button.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/third_profile_toggle_button.dart';

class ProfilesChoicePage extends StatefulWidget {
  const ProfilesChoicePage({Key? key}) : super(key: key);

  @override
  State<ProfilesChoicePage> createState() => _ProfilesChoicePageState();
}

class _ProfilesChoicePageState extends State<ProfilesChoicePage> {
  String mainProfilesLessons = "d";
  String thirdProfileLesson = "d";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 30.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocProvider(
                create: (context) => ProfilesChoiceCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonHeader(
                      title: "Выбор профильных предметов",
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      "Основные профильные",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    // MainProfilesToggleButton(
                    //   onChanged: ({required String mainProfilesValue}) {
                    //     setState(
                    //       () {
                    //         mainProfilesLessons = mainProfilesValue;
                    //       },
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "Третий профильный",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ThirdProfileToggleButton(
                      onChanged: ({required String thirdProfileValue}) {
                        setState(
                          () {
                            thirdProfileLesson = thirdProfileValue;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ProfilesChoiceCubit(),
                child: ProfilesChoicePageButton(
                  mainProfiles: mainProfilesLessons,
                  thirdProfile: thirdProfileLesson,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
