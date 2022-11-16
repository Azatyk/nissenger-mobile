import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/profile_groups_request_cubit/profile_groups_request_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/view/components/profile_groups_list.dart';

class ProfilesGroupsLists extends StatelessWidget {
  final String firstProfileActiveGroup;
  final String secondProfileActiveGroup;
  final String thirdProfileActiveGroup;
  final Function({required String firstGroup}) firstGroupChanged;
  final Function({required String secondGroup}) secondGroupChanged;
  final Function({required String thirdGroup}) thirdGroupChanged;

  const ProfilesGroupsLists({
    Key? key,
    required this.firstProfileActiveGroup,
    required this.secondProfileActiveGroup,
    required this.thirdProfileActiveGroup,
    required this.firstGroupChanged,
    required this.secondGroupChanged,
    required this.thirdGroupChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<ProfileGroupsRequestCubit, ProfileGroupsRequestState>(
      builder: (context, state) => state is ProfileGroupsRequestLoading
          ? Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Center(
                child: SizedBox(
                  width: 40.r,
                  height: 40.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.r,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            )
          : state is ProfileGroupsRequestData
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ProfileGroupsList(
                    profileGroups: state.profileGroups[index],
                    onGroupClicked: ({required String clickedGroup}) {
                      if (index == 0) {
                        firstGroupChanged(firstGroup: clickedGroup);
                      } else if (index == 1) {
                        secondGroupChanged(secondGroup: clickedGroup);
                      } else if (index == 2) {
                        thirdGroupChanged(thirdGroup: clickedGroup);
                      }
                    },
                    activeGroup: index == 0
                        ? firstProfileActiveGroup
                        : index == 1
                            ? secondProfileActiveGroup
                            : index == 2
                                ? thirdProfileActiveGroup
                                : "",
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 30.h),
                  itemCount: state.profileGroups.length,
                )
              : Container(),
    );
  }
}
