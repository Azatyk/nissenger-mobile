import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/profiles_choice/view/pages/profiles_choice_page.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/view/pages/ten_grade_profile_choice_page.dart';

class ForeignLanguagePageButton extends StatelessWidget {
  final List<String> foreignLanguages;

  const ForeignLanguagePageButton({
    Key? key,
    required this.foreignLanguages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForeignLanguageChoiceCubit, ForeignLanguageChoiceState>(
      listenWhen: (prevState, newState) =>
          newState is ForeignLanguageChoiceReadyToPush,
      listener: (context, state) {
        int gradeNumber =
            (state as ForeignLanguageChoiceReadyToPush).gradeNumber;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => gradeNumber == 10
                ? const TenGradeProfileChoicePage()
                : gradeNumber == 11 || gradeNumber == 12
                    ? const ProfilesChoicePage()
                    : const SchedulePage(),
          ),
        );
      },
      builder: (context, state) => CommonButton(
        disabled: foreignLanguages.isEmpty,
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ForeignLanguageChoiceCubit>(context)
              .saveForeignLanguage(foreignLanguages: foreignLanguages);
        },
      ),
    );
  }
}
