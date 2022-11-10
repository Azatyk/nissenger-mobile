import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
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
    } catch (err) {
      //error handling
    }
  }
}
