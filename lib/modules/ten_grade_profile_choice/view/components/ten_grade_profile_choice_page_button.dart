import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/data/ten_grade_profile_choice_cubit/ten_grade_profile_choice_cubit.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/data/ten_grade_profile_choice_cubit/ten_grade_profile_choice_state.dart';

class TenGradeProfileChoicePageButton extends StatelessWidget {
  final String profile;

  const TenGradeProfileChoicePageButton({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TenGradeProfileChoiceCubit, TenGradeProfileChoiceState>(
      listenWhen: (prevState, newState) =>
          newState is TenGradeProfileChoiceReadyToPush,
      listener: (context, state) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SchedulePage(),
          ),
        );
      },
      builder: (context, state) => CommonButton(
        disabled: profile == "",
        text: LangKeys.ready.translate(context),
        onPressed: () {
          BlocProvider.of<TenGradeProfileChoiceCubit>(context)
              .saveProfileChoice(profile: profile);
          BlocProvider.of<TenGradeProfileChoiceCubit>(context)
              .clearActivePresetBox();
        },
      ),
    );
  }
}
