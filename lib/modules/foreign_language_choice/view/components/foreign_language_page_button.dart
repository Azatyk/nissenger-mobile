import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_cubit.dart';
import 'package:nissenger_mobile/modules/foreign_language_choice/data/foreign_language_choice_cubit/foreign_language_request_cubit/foreign_language_choice_state.dart';
import 'package:nissenger_mobile/modules/profiles_choice_cubit/view/pages/profiles_choice_page.dart';

class ForeignLanguagePageButton extends StatelessWidget {
  final String foreignLanguage;

  const ForeignLanguagePageButton({
    Key? key,
    required this.foreignLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForeignLanguageChoiceCubit, ForeignLanguageChoiceState>(
      listenWhen: (prevState, newState) =>
          newState is ForeignLanguageChoiceReadyToPush,
      listener: (context, state) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilesChoicePage(),
          ),
        );
      },
      builder: (context, state) => CommonButton(
        disabled: foreignLanguage == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<ForeignLanguageChoiceCubit>(context)
              .saveForeignLanguage(foreignLanguage: foreignLanguage);
        },
      ),
    );
  }
}
