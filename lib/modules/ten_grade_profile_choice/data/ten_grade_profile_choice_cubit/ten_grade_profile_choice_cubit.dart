import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/ten_grade_profile_choice/data/ten_grade_profile_choice_cubit/ten_grade_profile_choice_state.dart';

class TenGradeProfileChoiceCubit extends Cubit<TenGradeProfileChoiceState> {
  TenGradeProfileChoiceCubit() : super(const TenGradeProfileChoicePure());

  void saveProfileChoice({required String profile}) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.firstProfileGroup, profile);

    emit(const TenGradeProfileChoiceReadyToPush());
    emit(const TenGradeProfileChoicePure());
  }
}
