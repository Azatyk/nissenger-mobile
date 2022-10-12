import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_form_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/plain_data/languages.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/view/components/language_toggle_button.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/view/pages/profiles_choose_page.dart';

class ForeignLanguageChoicePage extends StatefulWidget {
  const ForeignLanguageChoicePage({Key? key}) : super(key: key);

  @override
  State<ForeignLanguageChoicePage> createState() => _ForeignLanguageChoicePageState();
}

class _ForeignLanguageChoicePageState extends State<ForeignLanguageChoicePage> {
  int foreignLanguageIndex = 0;

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
                create: (context) => ForeignLanguageFormCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHeader(
                      title: "Какой твой иностранный язык?",
                      onBackButtonPressed: () {},
                    ),
                    SizedBox(height: 36.h),
                    LanguageToggleButton(
                      onChanged: ({required int foreignLanguage}) {
                        setState(
                          () {
                            foreignLanguageIndex = foreignLanguage;
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => ForeignLanguageRequestCubit(),
                child: PageButton(
                  foreignLanguage: foreignLanguageIndex,
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
  final int foreignLanguage;

  const PageButton({
    Key? key,
    required this.foreignLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForeignLanguageRequestCubit,
        ForeignLanguageRequestState>(
      builder: (context, state) => CommonButton(
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ForeignLanguageRequestCubit>(context)
              .navigateToNextPage(
            foreignLanguage: languages[foreignLanguage],
          );
          print(foreignLanguage);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProfilesChoosePage(),
            ),
          );
        },
      ),
    );
  }
}
