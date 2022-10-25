import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/teachers_search_cubit/teachers_search_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/teachers_search_cubit/teachers_search_state.dart';
import 'package:nissenger_mobile/modules/teachers_search/view/components/teachers_list.dart';

class TeachersSearchPage extends StatefulWidget {
  const TeachersSearchPage({Key? key}) : super(key: key);

  @override
  State<TeachersSearchPage> createState() => _TeachersSearchPageState();
}

class _TeachersSearchPageState extends State<TeachersSearchPage> {
  String teacherName = "";

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
                create: (context) => TeacherSearchCubit(),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackButton(),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: TeachersListView(
                          onChanged: ({required String teacherFullName}) {
                            setState(
                              () {
                                teacherName = teacherFullName;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => TeacherSearchCubit(),
                child: PageButton(
                  teacherName: teacherName,
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
    return BlocBuilder<TeacherSearchCubit, TeachersSearchState>(
      builder: (context, state) => CommonHeader(
        title: "Найдите себя",
        onBackButtonPressed: () {
          // BlocProvider.of<TeacherSearchCubit>(context).navigateBack(
          //   context: context,
          // );
        },
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String teacherName;

  const PageButton({
    Key? key,
    required this.teacherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherSearchCubit, TeachersSearchState>(
      builder: (context, state) => CommonButton(
        disabled: teacherName == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<TeacherSearchCubit>(context).navigateToNextPage(
            teacherFullName: teacherName,
          );
        },
      ),
    );
  }
}
