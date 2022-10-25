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
  String firstName = "";
  String secondName = "";
  String thirdName = "";

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackButton(),
                        SizedBox(height: 36.h),
                        TeachersListView(
                          onChanged: ({required String firstNameTeacher, required String secondNameTeacher, required String thirdNameTeacher}) {
                            setState(
                              () {
                                firstName = firstNameTeacher;
                                secondName = secondNameTeacher; 
                                thirdName = thirdNameTeacher;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => TeacherSearchCubit(),
                child: const PageButton(
                  teacher1Name: "",
                  teacher2Name: "",
                  teacher3Name: "",
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
  final String teacher1Name;
  final String teacher2Name;
  final String teacher3Name;

  const PageButton({
    Key? key,
    required this.teacher1Name,
    required this.teacher2Name,
    required this.teacher3Name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherSearchCubit, TeachersSearchState>(
      builder: (context, state) => CommonButton(
        disabled: teacher1Name == "" || teacher2Name == "" || teacher3Name == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<TeacherSearchCubit>(context).navigateToNextPage(
            teacherFirstName: teacher1Name,
            teacherSecondName: teacher2Name,
            teacherThirdName: teacher3Name,
          );
        },
      ),
    );
  }
}
