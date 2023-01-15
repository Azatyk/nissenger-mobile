import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/pages/foreign_language_choice_page.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_form_cubit/grade_choice_form_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_choice_page_button.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_group_choice_block.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_letter_choice_slider.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_number_choice_slider.dart';
import 'package:nissenger_mobile/modules/profiles_choice/view/pages/profiles_choice_page.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/view/pages/ten_grade_profile_choice_page.dart';

class GradeChoicePage extends StatelessWidget {
  final VoidCallback? onBackButtonPressed;

  const GradeChoicePage({
    Key? key,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GradeChoiceRequestCubit(repository: UserSettingsRepository()),
        ),
        BlocProvider(
          create: (context) => GradeChoiceFormCubit(),
        ),
      ],
      child: GradeChoicePageContent(
        onBackButtonPressed: onBackButtonPressed,
      ),
    );
  }
}

class GradeChoicePageContent extends StatefulWidget {
  final VoidCallback? onBackButtonPressed;

  const GradeChoicePageContent({
    Key? key,
    required this.onBackButtonPressed,
  }) : super(key: key);

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
    ThemeData theme = Theme.of(context);

    return BlocConsumer<GradeChoiceRequestCubit, GradeChoiceRequestState>(
      listener: (context, state) {
        if (state is GradeChoiceGradeExistingChecked) {
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
                  : gradeNumber == 10
                      ? const TenGradeProfileChoicePage()
                      : gradeNumber == 11 || gradeNumber == 12
                          ? const ProfilesChoicePage()
                          : const SchedulePage(),
            ),
          );
        } else if (state is GradeChoiceGradeCheckingFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: "Такого класса не существует",
              theme: theme,
            ),
          );
        } else if (state is GradeChoiceGradeCheckingInternetConnectionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackbar(
              text: "Нет интернет соединения",
              theme: theme,
            ),
          );
        }
      },
      builder: (context, state) {
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
                vertical: defaultTargetPlatform == TargetPlatform.android
                    ? 30.h
                    : 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHeader(
                                title: "Выбор класса",
                                onBackButtonPressed: widget.onBackButtonPressed,
                              ),
                              state is GradeChoiceGradeCheckingUnknownError
                                  ? Flexible(
                                      child: ErrorBlock(
                                        errorType: ErrorTypes.unknownError,
                                        onMainButtonPressed: () {
                                          BlocProvider.of<
                                                      GradeChoiceRequestCubit>(
                                                  context)
                                              .checkGradeExisting(
                                            gradeNumber: gradeNumber,
                                            gradeLetter: gradeLetter,
                                          );
                                        },
                                        secondaryButton: true,
                                      ),
                                    )
                                  : Flexible(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 36.h),
                                            GradeNumberChoiceSlider(
                                              onChanged: (
                                                  {required int
                                                      chosenGradeNumber}) {
                                                setState(() {
                                                  gradeNumber =
                                                      chosenGradeNumber;
                                                });
                                              },
                                            ),
                                            SizedBox(height: 16.h),
                                            GradeLetterChoiceSlider(
                                              onChanged: (
                                                  {required String
                                                      chosenGradeLetter}) {
                                                setState(() {
                                                  gradeLetter =
                                                      chosenGradeLetter;
                                                });
                                              },
                                            ),
                                            SizedBox(height: 30.h),
                                            GradeGroupChoiceBlock(
                                              onChanged: (
                                                  {required int
                                                      chosenGradeGroup}) {
                                                setState(() {
                                                  gradeGroup = chosenGradeGroup;
                                                });
                                              },
                                            ),
                                            //   SizedBox(height: 16.h),
                                            //   ForeignLanguageChoiceCheckbox(
                                            //     onChanged: (
                                            //         {required bool?
                                            //             hasForeignLanguage}) {
                                            //       setState(
                                            //         () {
                                            //           foreignLanguage =
                                            //               hasForeignLanguage!;
                                            //         },
                                            //       );
                                            //     },
                                            //   ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is! GradeChoiceGradeCheckingUnknownError)
                    GradeChoicePageButton(
                      gradeNumber: gradeNumber,
                      gradeLetter: gradeLetter,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
