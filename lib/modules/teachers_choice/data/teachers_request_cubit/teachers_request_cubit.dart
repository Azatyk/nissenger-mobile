import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/mock/mock_teachers.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teachers_request_cubit/teachers_request_state.dart';

class TeachersRequestCubit extends Cubit<TeachersRequestState> {
  TeachersRequestCubit() : super(const TeachersRequestLoading()) {
    loadTeachers();
  }

  void loadTeachers() async {
    emit(const TeachersRequestLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(
        TeachersRequestData(
          teachers: MockTeachers.getTeachers(),
        ),
      );
    } catch (err) {
      // to do: handle error
    }
  }
}
