import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_cubit.dart';
import 'package:nissenger_mobile/common/modals/support.modal.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';

class ForeignLanguagesList extends StatefulWidget {
  final Function({required String languageValue}) onActiveLanguageChanged;

  const ForeignLanguagesList({
    Key? key,
    required this.onActiveLanguageChanged,
  }) : super(key: key);

  @override
  State<ForeignLanguagesList> createState() => _ForeignLanguagesListState();
}

class _ForeignLanguagesListState extends State<ForeignLanguagesList> {
  String activeLanguage = "";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<ForeignLanguagesRequestCubit,
            ForeignLanguagesRequestState>(
        listenWhen: (prevState, newState) =>
            newState is ForeignLanguagesInternetConnectionError,
        listener: (context, state) {
          if (state is ForeignLanguagesInternetConnectionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnackbar(
                text: "Нет интернет соединения",
                theme: theme,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ForeignLanguagesRequestLoading) {
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
          } else if (state is ForeignLanguagesRequestData) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...state.languages.map(
                      (language) {
                        return CommonChoiceButton(
                          text: language.name,
                          onClicked: () {
                            if (activeLanguage != language.name) {
                              setState(() {
                                activeLanguage = language.name;
                              });

                              widget.onActiveLanguageChanged(
                                languageValue: language.name,
                              );
                            } else {
                              setState(() {
                                activeLanguage = "";
                              });

                              widget.onActiveLanguageChanged(
                                languageValue: "",
                              );
                            }
                          },
                          active: activeLanguage == language.name,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GradeChoiceGradeCheckingUnknownError) {
            return Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Center(
                child: ErrorBlock(
                  title: "Что-то пошло не так",
                  subtitle:
                      "Попробуйте обновить или напишите нам, мы разберемся",
                  mainButtonText: "Обновить",
                  onMainButtonPressed: () {
                    BlocProvider.of<ForeignLanguagesRequestCubit>(context)
                        .getLanguages();
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
