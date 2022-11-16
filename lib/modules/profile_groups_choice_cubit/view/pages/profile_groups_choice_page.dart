import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_choice_cubit/profile_groups_choice_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/types/profile_groups_choice.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/profiles_groups_lists.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/pages/schedule_page.dart';

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
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonHeader(
                      title: "Последнее: профильные группы",
                    ),
                    SizedBox(height: 25.h),
                    BlocProvider(
                      create: (context) => ProfileGroupsRequestCubit(),
                      child: const Expanded(
                        child: ProfilesGroupsLists(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ProfileGroupsChoicePageButton extends StatelessWidget {
  final String firstGroup;
  final String secondGroup;
  final String thirdGroup;

  const ProfileGroupsChoicePageButton({
    Key? key,
    required this.firstGroup,
    required this.secondGroup,
    required this.thirdGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileGroupsChoiceCubit, ProfileGroupsChoiceState>(
      listenWhen: (prevState, newState) =>
          newState.groupsChoiceState == GroupsChoiceState.readyToPush,
      listener: (context, state) {
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute<void>(
            builder: (context) => const SchedulePage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
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
