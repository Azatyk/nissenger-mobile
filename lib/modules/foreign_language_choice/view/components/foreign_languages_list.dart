import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/common/components/error_block.dart';
import 'package:nissenger_mobile/common/components/error_snackbar.dart';
import 'package:nissenger_mobile/helpers/error_messages.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_state.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';

class ForeignLanguagesList extends StatefulWidget {
  final Function({required List<String> activeLanguages})
      onActiveLanguagesChanged;

  const ForeignLanguagesList({
    Key? key,
    required this.onActiveLanguagesChanged,
  }) : super(key: key);

  @override
  State<ForeignLanguagesList> createState() => _ForeignLanguagesListState();
}

class _ForeignLanguagesListState extends State<ForeignLanguagesList> {
  List<String> activeLanguages = [];

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
                text: LangKeys.noInternetConnection.translate(context),
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
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  spacing: 12.r,
                  runSpacing: 12.r,
                  children: [
                    ...state.languages.map(
                      (language) {
                        return CommonChoiceButton(
                          text: language.name,
                          onClicked: () {
                            if (!activeLanguages.contains(language.name)) {
                              setState(() {
                                activeLanguages.add(language.name);
                              });

                              widget.onActiveLanguagesChanged(
                                activeLanguages: activeLanguages,
                              );
                            } else {
                              setState(() {
                                activeLanguages.remove(language.name);
                              });

                              widget.onActiveLanguagesChanged(
                                activeLanguages: activeLanguages,
                              );
                            }
                          },
                          active: activeLanguages.contains(language.name),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GradeChoiceGradeCheckingUnknownError) {
            return ErrorBlock(
              errorType: ErrorTypes.unknownError,
              onMainButtonPressed: () {
                BlocProvider.of<ForeignLanguagesRequestCubit>(context)
                    .getLanguages();
              },
              secondaryButton: true,
            );
          } else {
            return Container();
          }
        });
  }
}
