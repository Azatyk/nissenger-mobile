import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_cubit.dart';
import 'package:nissenger_mobile/modules/grade_choice/data/grade_choice_request_cubit/grade_choice_request_state.dart';

class GradeChoicePageButton extends StatelessWidget {
  final int gradeNumber;
  final String gradeLetter;

  const GradeChoicePageButton({
    Key? key,
    required this.gradeNumber,
    required this.gradeLetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeChoiceRequestCubit, GradeChoiceRequestState>(
      builder: (context, state) => CommonButton(
        loading: state is GradeChoiceGradeExistingLoading,
        text: LangKeys.proceed.translate(context),
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<GradeChoiceRequestCubit>(context).checkGradeExisting(
            gradeNumber: gradeNumber,
            gradeLetter: gradeLetter,
          );
        },
      ),
    );
  }
}
