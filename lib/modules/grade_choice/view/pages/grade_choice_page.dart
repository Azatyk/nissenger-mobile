import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/pages/foreign_language_choice_page.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/foreign_language_choice_checkbox.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_choice_page_button.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_group_choice_block.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_letter_choice_slider.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_number_choice_slider.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/pages/profiles_choose_page.dart';

class GradeChoicePage extends StatelessWidget {
  const GradeChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GradeChoiceRequestCubit(),
        ),
        BlocProvider(
          create: (context) => GradeChoiceFormCubit(),
        ),
      ],
      child: const GradeChoicePageContent(),
    );
  }
}

class GradeChoicePageContent extends StatefulWidget {
  const GradeChoicePageContent({Key? key}) : super(key: key);

  @override
  State<GradeChoicePageContent> createState() => _GradeChoicePageContentState();
}

class _GradeChoicePageContentState extends State<GradeChoicePageContent> {
  double gradeNumberSliderValue = 7;

  int gradeNumber = 8;
  String gradeLetter = "K";
  int gradeGroup = 1;
  bool foreignLanguage = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GradeChoiceRequestCubit, GradeChoiceRequestState>(
      listenWhen: (prevState, newState) =>
          newState is GradeChoiceGradeExistingChecked,
      listener: (context, state) {
        BlocProvider.of<GradeChoiceRequestCubit>(context).saveGradeChoiceData(
          gradeNumber: gradeNumber,
          gradeLetter: gradeLetter,
          gradeGroup: gradeGroup,
          hasForeignLanguage: foreignLanguage,
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => foreignLanguage
                ? const ForeignLanguageChoicePage()
                : const ProfilesChoosePage(),
          ),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 27.w,
              vertical: 30.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonHeader(
                          title: "Выбор класса",
                          onBackButtonPressed: () {
                            Navigator.of(context).pushAndRemoveUntil<void>(
                              MaterialPageRoute<void>(
                                builder: (context) => const GreetingPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        SizedBox(height: 36.h),
                        GradeNumberChoiceSlider(
                          onChanged: ({required int gradeNumber}) {
                            setState(() {
                              gradeNumber = gradeNumber;
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        GradeLetterChoiceSlider(
                          onChanged: ({required String gradeLetter}) {
                            setState(() {
                              gradeLetter = gradeLetter;
                            });
                          },
                        ),
                        SizedBox(height: 30.h),
                        GradeGroupChoiceBlock(
                          onChanged: ({required int group}) {
                            setState(() {
                              gradeGroup = group;
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        ForeignLanguageChoiceCheckbox(
                          onChanged: ({required bool? hasForeignLanguage}) {
                            setState(
                              () {
                                foreignLanguage = hasForeignLanguage!;
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
                GradeChoicePageButton(
                  gradeNumber: gradeNumber,
                  gradeLetter: gradeLetter,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
