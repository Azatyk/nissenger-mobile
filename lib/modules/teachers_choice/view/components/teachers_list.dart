import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_state.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_state.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/components/teachers_search_text_field.dart';

class TeachersList extends StatefulWidget {
  final Function({
    required String teacher,
  }) activeTeacherChanged;

  const TeachersList({
    required this.activeTeacherChanged,
    super.key,
  });

  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  String activeTeacher = "";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<TeachersRequestCubit, TeachersRequestState>(
      listenWhen: (prevState, newState) => newState is TeachersRequestData,
      listener: (context, state) =>
          BlocProvider.of<TeachersSearchCubit>(context).setInitialTeachersList(
        teachers: (state as TeachersRequestData).teachers,
      ),
      builder: (context, state) => state is TeachersRequestLoading
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
          : state is TeachersRequestData
              ? BlocBuilder<TeachersSearchCubit, TeachersSearchState>(
                  builder: (context, state) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: TeachersSearchTextField(
                          onQueryChanged: (String value) {
                            setState(() {
                              searchQuery = value;
                            });

                            BlocProvider.of<TeachersSearchCubit>(context)
                                .changeSearchQuery(query: value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const DashedDivider();
                          },
                          itemCount: searchQuery == ""
                              ? state.initialTeachersList.length
                              : state.searchedTeachersList.length,
                          itemBuilder: (context, index) {
                            return CupertinoButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 20.h,
                              ),
                              onPressed: () {
                                if (searchQuery == ""
                                    ? state.initialTeachersList[index] !=
                                        activeTeacher
                                    : state.searchedTeachersList[index] !=
                                        activeTeacher) {
                                  setState(() {
                                    activeTeacher = searchQuery == ""
                                        ? state.initialTeachersList[index]
                                        : state.searchedTeachersList[index];

                                    widget.activeTeacherChanged(
                                      teacher: activeTeacher,
                                    );
                                  });
                                } else {
                                  setState(() {
                                    activeTeacher = "";
                                  });

                                  widget.activeTeacherChanged(
                                    teacher: activeTeacher,
                                  );
                                }

                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  searchQuery == ""
                                      ? state.initialTeachersList[index]
                                      : state.searchedTeachersList[index],
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 14.sp,
                                    color: (searchQuery == ""
                                            ? state.initialTeachersList[
                                                    index] ==
                                                activeTeacher
                                            : state.searchedTeachersList[
                                                    index] ==
                                                activeTeacher)
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
    );
  }
}
