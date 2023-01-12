import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/data/plain_data/profile_options.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/data/profiles_choice_cubit/profiles_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/view/components/profile_choice_options.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/view/components/profiles_choice_page_button.dart';

class ProfilesChoicePage extends StatefulWidget {
  const ProfilesChoicePage({Key? key}) : super(key: key);

  @override
  State<ProfilesChoicePage> createState() => _ProfilesChoicePageState();
}

class _ProfilesChoicePageState extends State<ProfilesChoicePage> {
  String mainProfilesLessons = "";
  String thirdProfileLesson = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical:
                defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocProvider(
                create: (context) => ProfilesChoiceCubit(),
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonHeader(
                        title: "Выбор профильных предметов",
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              ProfileChoiceOptions(
                                profileOptions:
                                    ProfileOptions.profileLessonsNames,
                                profileClicked: (
                                    {required String clickedProfile}) {
                                  setState(() {
                                    mainProfilesLessons = clickedProfile;
                                  });
                                },
                                activeProfile: mainProfilesLessons,
                              ),
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
                              ProfileChoiceOptions(
                                profileOptions:
                                    ProfileOptions.thirdProfileLessonName,
                                profileClicked: (
                                    {required String clickedProfile}) {
                                  setState(() {
                                    thirdProfileLesson = clickedProfile;
                                  });
                                },
                                activeProfile: thirdProfileLesson,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
