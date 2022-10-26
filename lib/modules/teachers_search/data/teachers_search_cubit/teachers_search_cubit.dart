import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';
import 'package:nissenger_mobile/modules/schedule_display/view/pages/schedule_display_page.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/teachers_search_cubit/teachers_search_state.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/types/search_states.dart';

class TeacherSearchCubit extends Cubit<TeachersSearchState> {
  TeacherSearchCubit()
      : super(
          const TeachersSearchState(
            searchStatus: SearchStatus.pure,
            teacherName: "",
          ),
        );

  void navigateToNextPage({
    required String teacherFullName,
    required BuildContext context,
  }) async {
    emit(
      TeachersSearchState(
        searchStatus: SearchStatus.loading,
        teacherName: teacherFullName,
      ),
    );

    try {
      var box = Hive.box(UserSettingsBox.boxName);

      box.put(UserSettingsBox.teacherFullName, teacherFullName);

      emit(
        TeachersSearchState(
          searchStatus: SearchStatus.readyToPush,
          teacherName: teacherFullName,
        ),
      );

      if (state.searchStatus == SearchStatus.readyToPush) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil<void>(
          MaterialPageRoute<void>(
            builder: (context) => const ScheduleDisplayPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (err) {
      //error handling
    }
  }

  void navigateBack({required BuildContext context}) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(
        builder: (context) => const GreetingPage(),
      ),
      (Route<dynamic> route) => false,
    );
    emit(
      const TeachersSearchState(
        searchStatus: SearchStatus.pure,
        teacherName: "",
      ),
    );
  }
}
