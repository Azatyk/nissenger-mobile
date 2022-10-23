import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/plain_data/profile_names.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/first_group_toggle_button.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/second_group_toggle_button.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/third_group_toggle_button.dart';

class ProfileGroupsChoicePage extends StatefulWidget {
  const ProfileGroupsChoicePage({Key? key}) : super(key: key);

  @override
  State<ProfileGroupsChoicePage> createState() =>
      _ProfileGroupsChoicePageState();
}

class _ProfileGroupsChoicePageState extends State<ProfileGroupsChoicePage> {
  String firstGroupName = "";
  String secondGroupName = "";
  String thirdGroupName = "";

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
                create: (context) => ProfileGroupsChoiceCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(),
                    SizedBox(height: 25.h),
                    Text(
                      "Группа по ${profileGroups[firstProfile]}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    FirstGroupToggleButton(
                      onChanged: ({required String firstGroupValue}) {
                        setState(
                          () {
                            firstGroupName = firstGroupValue;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "Группа по ${profileGroups[secondProfile]}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    SecondGroupToggleButton(
                      onChanged: ({required String secondGroupValue}) {
                        setState(
                          () {
                            secondGroupName = secondGroupValue;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "Группа по ${profileGroups[thirdProfile]}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ThirdGroupToggleButton(
                      onChanged: ({required String thirdGroupValue}) {
                        setState(
                          () {
                            thirdGroupName = thirdGroupValue;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ProfileGroupsChoiceCubit(),
                child: PageButton(
                  firstGroup: firstGroupName,
                  secondGroup: secondGroupName,
                  thirdGroup: thirdGroupName,
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
    return BlocBuilder<ProfileGroupsChoiceCubit, ProfileGroupsChoiceState>(
      builder: (context, state) => CommonHeader(
        title: "Последнее: профильные группы",
        onBackButtonPressed: () {
          BlocProvider.of<ProfileGroupsChoiceCubit>(context).navigateBack(
            context: context,
          );
        },
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String firstGroup;
  final String secondGroup;
  final String thirdGroup;

  const PageButton(
      {Key? key,
      required this.firstGroup,
      required this.secondGroup,
      required this.thirdGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileGroupsChoiceCubit, ProfileGroupsChoiceState>(
      builder: (context, state) => CommonButton(
        disabled: firstGroup == "" || secondGroup == "" || thirdGroup == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ProfileGroupsChoiceCubit>(context).navigateToNextPage(
            firstGroup: firstGroup,
            secondGroup: secondGroup,
            thirdGroup: thirdGroup,
            context: context,
          );
        },
      ),
    );
  }
}
