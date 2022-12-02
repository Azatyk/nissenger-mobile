import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/helpers/user_profile_choice_text.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_cubit.dart';
import 'package:nissenger_mobile/modules/profile/data/profile_data_cubit/profile_data_state.dart';
import 'package:nissenger_mobile/modules/profile/view/components/profile_links.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDataCubit(),
      child: const ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  State<ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  @override
  void initState() {
    BlocProvider.of<ProfileDataCubit>(context).getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<ProfileDataCubit, ProfileDataState>(
        builder: (context, state) {
      String studentProfileChoiceText = "";

      if (state is ProfileData) {
        studentProfileChoiceText =
            UserProfileChoiceText.getChoiceText(state: state);
      }

      return state is ProfileData
          ? Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 27.w,
                    vertical: defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHeader(
                        title: state.userType == UserTypes.student
                            ? "Твой профиль"
                            : state.userType == UserTypes.teacher
                                ? "Ваш профиль"
                                : "",
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        state.userType == UserTypes.student
                            ? "${state.gradeNumber}${state.gradeLetter} класс, ${state.gradeGroup} группа"
                            : state.userType == UserTypes.teacher
                                ? state.teacherName ?? ""
                                : "",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      if (state.userType == UserTypes.student)
                        studentProfileChoiceText != ""
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: theme.colorScheme.background,
                                  ),
                                  child: Text(
                                    studentProfileChoiceText,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontSize: 14.sp,
                                      color: theme.colorScheme.onSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      if (state.userType == UserTypes.teacher ||
                          studentProfileChoiceText == "")
                        SizedBox(height: 20.h),
                      const Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: ProfileLinks(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container();
    });
  }
}
