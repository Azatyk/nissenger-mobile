import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
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
        listener: (context, state) {
      if (state is TeachersRequestData) {
        BlocProvider.of<TeachersSearchCubit>(context).setInitialTeachersList(
          teachers: state.teachers,
        );
      } else if (state is TeachersUnknownError) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackbar(
            text: "Нет интернет соединения",
            theme: theme,
          ),
        );
      }
    }, builder: (context, state) {
      if (state is TeachersRequestLoading) {
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
      } else if (state is TeachersRequestData) {
        return BlocBuilder<TeachersSearchCubit, TeachersSearchState>(
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
                            ? state.initialTeachersList[index].name !=
                                activeTeacher
                            : state.searchedTeachersList[index].name !=
                                activeTeacher) {
                          setState(() {
                            activeTeacher = searchQuery == ""
                                ? state.initialTeachersList[index].name
                                : state.searchedTeachersList[index].name;

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
                              ? state.initialTeachersList[index].name
                              : state.searchedTeachersList[index].name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp,
                            color: (searchQuery == ""
                                    ? state.initialTeachersList[index].name ==
                                        activeTeacher
                                    : state.searchedTeachersList[index].name ==
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
        );
      } else if (state is TeachersUnknownError) {
        return Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Center(
            child: ErrorBlock(
              title: "Что-то пошло не так",
              subtitle: "Попробуйте обновить или напишите нам, мы разберемся",
              mainButtonText: "Обновить",
              onMainButtonPressed: () {
                BlocProvider.of<TeachersRequestCubit>(context).loadTeachers();
              },
              secondaryButton: true,
              secondaryButtonText: "Написать нам",
              onSecondaryButtonPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                      20.r,
                    )),
                  ),
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => SupportCubit(),
                    child: const SupportMethodsModal(),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
