import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/types/foreign_language_status.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/components/language_toggle_button.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/pages/profiles_choose_page.dart';

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonHeader(
                        title: "Какой твой иностранный язык?",
                      ),
                      SizedBox(height: 36.h),
                      LanguageToggleButton(
                        onChanged: ({required String languageValue}) {
                          setState(
                            () {
                              foreignLanguageName = languageValue;
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => ForeignLanguageChoiceCubit(),
                child: PageButton(
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

class PageButton extends StatelessWidget {
  final String foreignLanguage;

  const PageButton({
    Key? key,
    required this.foreignLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForeignLanguageChoiceCubit, ForeignLanguageChoiceState>(
      listenWhen: (prevState, newState) =>
          newState.foreignLanguageState == ForeignLanguageState.readyToPush,
      listener: (context, state) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilesChoosePage(),
          ),
        );
      },
      builder: (context, state) => CommonButton(
        disabled: foreignLanguage == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ForeignLanguageChoiceCubit>(context)
              .navigateToNextPage(
            foreignLanguage: foreignLanguage,
            context: context,
          );
        },
      ),
    );
  }
}
