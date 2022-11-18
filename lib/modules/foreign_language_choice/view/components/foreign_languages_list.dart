import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_choice_button.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_state.dart';

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

    return BlocBuilder<ForeignLanguagesRequestCubit,
        ForeignLanguagesRequestState>(
      builder: (context, state) => state is ForeignLanguagesRequestLoading
          ? Padding(
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
            )
          : state is ForeignLanguagesRequestData
              ? SizedBox(
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
                )
              : Container(),
    );
  }
}
