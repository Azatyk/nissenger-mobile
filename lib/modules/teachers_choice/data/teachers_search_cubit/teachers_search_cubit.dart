import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_search_cubit/teachers_search_state.dart';

class TeachersSearchCubit extends Cubit<TeachersSearchState> {
  TeachersSearchCubit()
      : super(
          const TeachersSearchState(
            searchedTeachersList: [],
            initialTeachersList: [],
          ),
        );

  void setInitialTeachersList({required List<String> teachers}) {
    emit(
      TeachersSearchState(
        searchedTeachersList: const [],
        initialTeachersList: teachers,
      ),
    );
  }

  void changeSearchQuery({
    required String query,
  }) {
    List<String> matchedTeachers = [];
    List<String> allTeachers = state.initialTeachersList;

    for (int i = 0; i < allTeachers.length; i++) {
      if (allTeachers[i].toLowerCase().contains(query.toLowerCase())) {
        matchedTeachers.add(allTeachers[i]);
      }
    }

    emit(
      TeachersSearchState(
        searchedTeachersList: matchedTeachers,
        initialTeachersList: allTeachers,
      ),
    );
  }
}
