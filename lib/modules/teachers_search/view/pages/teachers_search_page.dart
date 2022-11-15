import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/teachers_search_cubit/teachers_search_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/teachers_search_cubit/teachers_search_state.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/types/search_states.dart';
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

class PageButton extends StatelessWidget {
  final String teacherName;

  const PageButton({
    Key? key,
    required this.teacherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSearchCubit, TeachersSearchState>(
      listenWhen: (prevState, newState) =>
          newState.searchStatus == SearchStatus.readyToPush,
      listener: (context, state) {
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute<void>(
            builder: (context) => const SchedulePage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      builder: (context, state) => CommonButton(
        disabled: teacherName == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<TeacherSearchCubit>(context).navigateToNextPage(
            teacherFullName: teacherName,
            context: context,
          );
        },
      ),
    );
  }
}
