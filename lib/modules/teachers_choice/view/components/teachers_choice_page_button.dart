import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/schedule/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teacher_choice_cubit/teachers_choice_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teacher_choice_cubit/teachers_choice_state.dart';

class TeachersChoicePageButton extends StatelessWidget {
  final String teacherName;

  const TeachersChoicePageButton({
    Key? key,
    required this.teacherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherChoiceCubit, TeacherChoiceState>(
      listenWhen: (prevState, newState) => newState is TeacherChoiceReadyToPush,
      listener: (context, state) {
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute<void>(
            builder: (context) => const SchedulePage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      builder: (context, state) => CommonButton(
        disabled: teacherName == "",
        text: "Далее",
        icon: FontAwesomeIcons.arrowRight,
        onPressed: () {
          BlocProvider.of<TeacherChoiceCubit>(context).saveTeacherChoice(
            teacher: teacherName,
          );
        },
      ),
    );
  }
}
