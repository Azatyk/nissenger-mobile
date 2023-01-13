import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice/data/profile_groups_request_cubit/profile_groups_request_cubit.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice/data/profile_groups_request_cubit/profile_groups_request_state.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice/view/components/profile_groups_list.dart';

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

    return BlocConsumer<ProfileGroupsRequestCubit, ProfileGroupsRequestState>(
        listenWhen: (prevState, newState) =>
            newState is ProfileGroupsInternetConnectionError,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: "Нет интернет соединения",
              theme: theme,
            ),
          );
        },
        builder: (context, state) {
          if (state is ProfileGroupsRequestLoading) {
            return Padding(
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
            );
          } else if (state is ProfileGroupsRequestData) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (state.profileGroups[index].groups.isNotEmpty) {
                  if (state.profileGroups[index].groups.length > 1) {
                    return ProfileGroupsList(
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
                    );
                  } else {
                    switch (index) {
                      case 0:
                        firstGroupChanged(
                            firstGroup: state.profileGroups[index].groups[0]);
                        break;
                      case 1:
                        secondGroupChanged(
                            secondGroup: state.profileGroups[index].groups[0]);
                        break;
                      case 2:
                        thirdGroupChanged(
                            thirdGroup: state.profileGroups[index].groups[0]);
                        break;
                    }
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
              separatorBuilder: (context, index) =>
                  state.profileGroups[index].groups.isNotEmpty
                      ? SizedBox(height: 30.h)
                      : Container(),
              itemCount: state.profileGroups.length,
            );
          } else if (state is ProfileGroupsUnknownError) {
            return ErrorBlock(
              errorType: ErrorTypes.unknownError,
              onMainButtonPressed: () {
                BlocProvider.of<ProfileGroupsRequestCubit>(context)
                    .loadProfileGroups();
              },
              secondaryButton: true,
            );
          } else {
            return Container();
          }
        });
  }
}
