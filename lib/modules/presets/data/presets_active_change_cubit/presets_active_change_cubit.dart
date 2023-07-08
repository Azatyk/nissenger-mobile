import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';
import '../../../../config/hive_boxes.dart';

class PresetsActiveChangeCubit extends Cubit<PresetActiveChangeState> {
  PresetsActiveChangeCubit() : super(const PresetActiveChangePure());

  void changeActive({required Preset? presetValue}) {
    var box = Hive.box<Preset?>(ActivePresetBox.boxName);

    Preset? preset = presetValue;

    if (box.isEmpty) {
      box.add(preset);
    } else {
      box.putAt(0, preset);
    }

    emit(const PresetActiveChangeReadyToPush());
  }
}
