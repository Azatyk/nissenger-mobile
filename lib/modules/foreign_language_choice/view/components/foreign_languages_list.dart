import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      children: [
                        ...state.languages.map(
                          (language) {
                            return CupertinoButton(
                              padding:
                                  EdgeInsets.only(right: 14.w, bottom: 14.h),
                              onPressed: (() {
                                setState(
                                  () {
                                    if (activeLanguage == language.name) {
                                      activeLanguage = "";
                                      widget.onActiveLanguageChanged(
                                          languageValue: "");
                                    } else {
                                      activeLanguage = language.name;
                                      widget.onActiveLanguageChanged(
                                        languageValue: activeLanguage,
                                      );
                                    }
                                  },
                                );
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: activeLanguage == language.name
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.background,
                                ),
                                child: Text(
                                  language.name,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 14.47,
                                    color: activeLanguage == language.name
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.secondary,
                                  ),
                                ),
                              ),
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
