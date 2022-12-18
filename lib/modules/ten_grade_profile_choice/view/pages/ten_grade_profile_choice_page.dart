import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/data/ten_grade_profile_choice_cubit/ten_grade_profile_choice_cubit.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/view/components/ten_grade_profile_choice_page_button.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/view/components/ten_grade_profiles_list.dart';

class TenGradeProfileChoicePage extends StatefulWidget {
  const TenGradeProfileChoicePage({Key? key}) : super(key: key);

  @override
  State<TenGradeProfileChoicePage> createState() =>
      _TenGradeProfileChoicePageState();
}

class _TenGradeProfileChoicePageState extends State<TenGradeProfileChoicePage> {
  String profile = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
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
                    const CommonHeader(
                      title: "Какой у тебя профильный предмет?",
                    ),
                    SizedBox(height: 36.h),
                    Expanded(
                      child: TenGradeProfilesList(
                        onActiveProfileChanged: (
                            {required String profileValue}) {
                          setState(
                            () {
                              profile = profileValue;
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => TenGradeProfileChoiceCubit(),
                child: TenGradeProfileChoicePageButton(
                  profile: profile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
