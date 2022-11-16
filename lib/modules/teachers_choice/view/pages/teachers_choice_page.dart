import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teacher_choice_cubit/teachers_choice_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/components/teachers_choice_page_button.dart';
import 'package:nissenger_mobile/modules/teachers_choice/view/components/teachers_list.dart';

class TeachersChoicePage extends StatefulWidget {
  const TeachersChoicePage({Key? key}) : super(key: key);

  @override
  State<TeachersChoicePage> createState() => _TeachersChoicePageState();
}

class _TeachersChoicePageState extends State<TeachersChoicePage> {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHeader(
                      title: "Найдите себя",
                      onBackButtonPressed: () {
                        Navigator.of(context).pushAndRemoveUntil<void>(
                          MaterialPageRoute<void>(
                            builder: (context) => const GreetingPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => TeachersRequestCubit(),
                          ),
                          BlocProvider(
                            create: (context) => TeachersSearchCubit(),
                          ),
                        ],
                        child: TeachersList(
                          activeTeacherChanged: ({required String teacher}) {
                            setState(
                              () {
                                teacherName = teacher;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => TeacherChoiceCubit(),
                child: TeachersChoicePageButton(
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
