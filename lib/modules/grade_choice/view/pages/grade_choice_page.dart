import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/foreign_language_choice_checkbox.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_group_choice_block.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_letter_choice_slider.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_number_choice_slider.dart';

class GradeChoicePage extends StatefulWidget {
  const GradeChoicePage({Key? key}) : super(key: key);

  @override
  State<GradeChoicePage> createState() => _GradeChoicePageState();
}

class _GradeChoicePageState extends State<GradeChoicePage> {
  double gradeNumberSliderValue = 7;

  int gradeNumber = 8;
  String gradeLetter = "K";
  int gradeGroup = 1;
  bool hasForeignLanguage = false;

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
                create: (context) => GradeChoiceFormCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHeader(
                      title: "Выбор класса",
                      onBackButtonPressed: () {},
                    ),
                    SizedBox(height: 36.h),
                    GradeNumberChoiceSlider(
                      onChanged: ({required int gradeNumber}) {
                        // print(gradeNumber);
                        setState(() {
                          gradeNumber = gradeNumber;
                        });
                      },
                    ),
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 30.h),
                    ForeignLanguageChoiceCheckbox(
                      onChanged: ({required bool? hasForeignLanguage}) {
                        print(hasForeignLanguage);
                        setState(
                          () {
                            hasForeignLanguage = hasForeignLanguage;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => GradeChoiceRequestCubit(),
                child: PageButton(
                  gradeNumber: gradeNumber,
                  gradeLetter: gradeLetter,
                  gradeGroup: gradeGroup,
                  hasForeignLanguage: hasForeignLanguage,
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
  final int gradeNumber;
  final String gradeLetter;
  final int gradeGroup;
  final bool hasForeignLanguage;

  const PageButton({
    Key? key,
    required this.gradeNumber,
    required this.gradeLetter,
    required this.gradeGroup,
    required this.hasForeignLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeChoiceRequestCubit, GradeChoiceRequestState>(
      builder: (context, state) => CommonButton(
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<GradeChoiceRequestCubit>(context).navigateToNextPage(
            gradeNumber: gradeNumber,
            gradeLetter: gradeLetter,
            gradeGroup: gradeGroup,
            hasForeignLanguage: hasForeignLanguage,
          );
        },
      ),
    );
  }
}
