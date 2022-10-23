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
            teacherFirstName: "",
            teacherSecondName: "",
            teacherThirdName: "",
          ),
        );

  void navigateToNextPage({
    required String teacherFirstName,
    required String teacherSecondName,
    required String teacherThirdName
  }) async {
    emit(
      TeachersSearchState(
          searchStatus: SearchStatus.loading, 
          teacherFirstName: teacherFirstName,
          teacherSecondName: teacherSecondName, 
          teacherThirdName: teacherThirdName),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      var box = Hive.box(UserSettingsBox.boxName);

      box.put(UserSettingsBox.teacherFirstName, teacherFirstName);
      box.put(UserSettingsBox.teacherSecondName, teacherSecondName);
      box.put(UserSettingsBox.teacherThirdName, teacherThirdName);

      emit(
        TeachersSearchState(
            searchStatus: SearchStatus.readyToPush, 
            teacherFirstName: teacherFirstName,
            teacherSecondName: teacherSecondName, 
            teacherThirdName: teacherThirdName),
      );
    } catch (err) {
      //error handling
    }
  }
}
