import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/teachers_choice/data/teacher_choice_cubit/teachers_choice_state.dart';

class TeacherChoiceCubit extends Cubit<TeacherChoiceState> {
  TeacherChoiceCubit() : super(const TeacherChoicePure());

  void saveTeacherChoice({required String teacher}) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.teacherName, teacher);

    emit(const TeacherChoiceReadyToPush());
  }
}
