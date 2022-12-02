import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/profile_groups_choice_page_button.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/profiles_groups_lists.dart';

class ProfileGroupsChoicePage extends StatefulWidget {
  const ProfileGroupsChoicePage({Key? key}) : super(key: key);

  @override
  State<ProfileGroupsChoicePage> createState() =>
      _ProfileGroupsChoicePageState();
}

class _ProfileGroupsChoicePageState extends State<ProfileGroupsChoicePage> {
  String firstProfileGroup = "";
  String secondProfileGroup = "";
  String thirdProfileGroup = "";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileGroupsChoiceCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileGroupsRequestCubit(
            repository: UserSettingsRepository(),
          ),
        ),
      ],
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonHeader(
                      title: "Последнее: профильные группы",
                    ),
                    SizedBox(height: 25.h),
                    Expanded(
                      child: ProfilesGroupsLists(
                        firstProfileActiveGroup: firstProfileGroup,
                        secondProfileActiveGroup: secondProfileGroup,
                        thirdProfileActiveGroup: thirdProfileGroup,
                        firstGroupChanged: ({required String firstGroup}) {
                          setState(() {
                            firstProfileGroup = firstGroup;
                          });
                        },
                        secondGroupChanged: ({required String secondGroup}) {
                          setState(() {
                            secondProfileGroup = secondGroup;
                          });
                        },
                        thirdGroupChanged: ({required String thirdGroup}) {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              thirdProfileGroup = thirdGroup;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ProfileGroupsChoicePageButton(
                firstGroup: firstProfileGroup,
                secondGroup: secondProfileGroup,
                thirdGroup: thirdProfileGroup,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
