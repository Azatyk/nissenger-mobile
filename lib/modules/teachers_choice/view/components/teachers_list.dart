import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/plain_data/teachers_list.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_state.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/components/teachers_search_text_field.dart';

class TeachersList extends StatefulWidget {
  final Function({
    required String teacherFullName,
  }) onChanged;

  const TeachersList({
    required this.onChanged,
    super.key,
  });

  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  String query = "";
  String activeTeacherName = "";
  List<String> matchQuery = [];

  void updateMatchQueryList() {
    if (query.isNotEmpty) {
      matchQuery = [];

      for (var teacher in MockTeachers.getTeachers()) {
        if (teacher.toLowerCase().contains(query.toLowerCase())) {
          setState(() {
            matchQuery.add(teacher);
          });
        }
      }
    } else {
      setState(() {
        matchQuery = MockTeachers.getTeachers();
      });
    }
  }

  @override
  void initState() {
    updateMatchQueryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<TeachersRequestCubit, TeachersRequestState>(
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
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      child: TeachersSearchTextField(
                        fieldValue: (String value) {
                          query = value;
                          updateMatchQueryList();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const DashedDivider();
                        },
                        itemCount: matchQuery.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              if (activeTeacherName == matchQuery[index]) {
                                setState(() {
                                  activeTeacherName = "";
                                });

                                widget.onChanged(teacherFullName: "");
                              } else {
                                setState(() {
                                  activeTeacherName = matchQuery[index];
                                });

                                widget.onChanged(
                                  teacherFullName: activeTeacherName,
                                );
                              }
                            }),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: Text(
                                matchQuery[index],
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontSize: 14.sp,
                                  color: activeTeacherName == matchQuery[index]
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              : Container(),
    );
  }
}
