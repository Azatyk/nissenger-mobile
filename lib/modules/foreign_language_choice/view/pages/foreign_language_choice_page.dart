import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_languages_request_cubit/foreign_languages_request_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/components/foreign_language_page_button.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/components/foreign_languages_list.dart';

class ForeignLanguageChoicePage extends StatefulWidget {
  const ForeignLanguageChoicePage({Key? key}) : super(key: key);

  @override
  State<ForeignLanguageChoicePage> createState() =>
      _ForeignLanguageChoicePageState();
}

class _ForeignLanguageChoicePageState extends State<ForeignLanguageChoicePage> {
  String foreignLanguageName = "";

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
                create: (context) => ForeignLanguageChoiceCubit(),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonHeader(
                        title: "Какой твой иностранный язык?",
                      ),
                      SizedBox(height: 36.h),
                      Expanded(
                        child: BlocProvider(
                          create: (context) => ForeignLanguagesRequestCubit(),
                          child: ForeignLanguagesList(
                            onActiveLanguageChanged: (
                                {required String languageValue}) {
                              setState(
                                () {
                                  foreignLanguageName = languageValue;
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => ForeignLanguageChoiceCubit(),
                child: ForeignLanguagePageButton(
                  foreignLanguage: foreignLanguageName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
