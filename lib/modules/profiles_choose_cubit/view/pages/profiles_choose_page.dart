import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/plain_data/profile_names.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_form_cubit/profiles_choose_form_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_request_cubit/profiles_choose_request_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choose_cubit/profiles_choose_request_cubit/profiles_choose_request_state.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/profiles_toggle_button%20copy.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/third_profile_toggle_button.dart';

class ProfilesChoosePage extends StatefulWidget {
  const ProfilesChoosePage({Key? key}) : super(key: key);

  @override
  State<ProfilesChoosePage> createState() => _ProfilesChoosePageState();
}

class _ProfilesChoosePageState extends State<ProfilesChoosePage> {
  int mainProfilesIndex = 0;
  int thirdProfileIndex = 0;

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
                create: (context) => ProfilesChooseFormCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHeader(
                      title: "Выбор профильных предметов",
                      onBackButtonPressed: () {},
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Основные профильные",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ProfilesToggleButton(
                      onChanged: ({required int mainProfiles}) {
                        setState(
                          () {
                            mainProfilesIndex = mainProfiles;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.h,
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
                      onChanged: ({required int thirdProfile}) {
                        setState(
                          () {
                            thirdProfileIndex = thirdProfile;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ProfilesChooseRequestCubit(),
                child: PageButton(
                  mainProfiles: mainProfilesIndex,
                  thirdProfile: thirdProfileIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final int mainProfiles;
  final int thirdProfile;

  const PageButton({
    Key? key,
    required this.mainProfiles,
    required this.thirdProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesChooseRequestCubit, ProfilesChooseRequestState>(
      builder: (context, state) => CommonButton(
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ProfilesChooseRequestCubit>(context)
              .navigateToNextPage(
                  mainProfiles: profileNames[mainProfiles],
                  thirdProfile: thirdProfileName[thirdProfile]);
        },
      ),
    );
  }
}
