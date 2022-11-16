import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/pages/schedule_page.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_cubit.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_state.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/types/search_states.dart';

class TeachersChoicePageButton extends StatelessWidget {
  final String teacherName;

  const TeachersChoicePageButton({
    Key? key,
    required this.teacherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSearchCubit, TeachersSearchState>(
      listenWhen: (prevState, newState) =>
          newState.searchStatus == SearchStatus.readyToPush,
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
          BlocProvider.of<TeacherSearchCubit>(context).navigateToNextPage(
            teacherFullName: teacherName,
            context: context,
          );
        },
      ),
    );
  }
}
