import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/data/repositories/user_settings.repository.dart';
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
  List<String> foreignLanguages = [];

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
            vertical:
                defaultTargetPlatform == TargetPlatform.android ? 30.h : 20.h,
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
                          create: (context) => ForeignLanguagesRequestCubit(
                            repository: UserSettingsRepository(),
                          ),
                          child: ForeignLanguagesList(
                            onActiveLanguagesChanged: (
                                {required List<String> activeLanguages}) {
                              setState(
                                () {
                                  foreignLanguages = activeLanguages;
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
                  foreignLanguages: foreignLanguages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
