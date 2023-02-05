import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

import '../../../../config/hive_boxes.dart';

class PresetsActiveChangeCubit extends Cubit<PresetActiveChangeState> {
  PresetsActiveChangeCubit() : super(const PresetActiveChangePure());

  void changeActive({
    required int gradeNumber,
    required String gradeLetter,
    required int gradeGroup,
    required List<String> foreignLanguages,
    required String firstMainProfile,
    required String secondMainProfile,
    required String thirdProfile,
    required String firstProfileGroup,
    required String secondProfileGroup,
    required String thirdProfileGroup,
    required String teacherName,
    required String presetName,
  }) {
    var box = Hive.box<Preset>(ActivePresetBox.boxName);

    Preset preset = Preset(
        gradeNumber,
        gradeLetter,
        gradeGroup,
        foreignLanguages,
        firstMainProfile,
        secondMainProfile,
        thirdProfile,
        firstProfileGroup,
        secondProfileGroup,
        thirdProfileGroup,
        teacherName,
        presetName);

    box.putAt(0, preset);

    emit(const PresetActiveChangeReadyToPush());
  }
}
