import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/profiles_choice_cubit/profiles_choice_state.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/profiles_toggle_button%20copy.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/components/third_profile_toggle_button.dart';

class ProfilesChoosePage extends StatefulWidget {
  const ProfilesChoosePage({Key? key}) : super(key: key);

  @override
  State<ProfilesChoosePage> createState() => _ProfilesChoosePageState();
}

class _ProfilesChoosePageState extends State<ProfilesChoosePage> {
  String mainProfilesName = "";
  String thirdProfileName = "";

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
                    const BackButton(),
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
                    MainProfilesToggleButton(
                      onChanged: ({required String mainProfilesValue}) {
                        setState(
                          () {
                            mainProfilesName = mainProfilesValue;
                          },
                        );
                      },
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
                    ThirdProfileToggleButton(
                      onChanged: ({required String thirdProfileValue}) {
                        setState(
                          () {
                            thirdProfileName = thirdProfileValue;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ProfilesChoiceCubit(),
                child: PageButton(
                  mainProfiles: mainProfilesName,
                  thirdProfile: thirdProfileName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesChoiceCubit, ProfilesChoiceState>(
      builder: (context, state) => CommonHeader(
        title: "Выбор профильных предметов",
        onBackButtonPressed: () {
          BlocProvider.of<ProfilesChoiceCubit>(context)
              .navigateBack(context: context);
        },
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String mainProfiles;
  final String thirdProfile;

  const PageButton({
    Key? key,
    required this.mainProfiles,
    required this.thirdProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesChoiceCubit, ProfilesChoiceState>(
      builder: (context, state) => CommonButton(
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ProfilesChoiceCubit>(context).navigateToNextPage(
            mainProfiles: mainProfiles,
            thirdProfile: thirdProfile,
            context: context,
          );
        },
      ),
    );
  }
}
