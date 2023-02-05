import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_request_cubit/presets_request_state.dart';

import '../../../../config/hive_boxes.dart';

class PresetsRequestCubit extends Cubit<PresetsRequestState> {
  PresetsRequestCubit() : super(const PresetsLoading()) {
    loadPresets();
  }

  void loadPresets() async {
    emit(
      const PresetsLoading(),
    );

    var boxPresets = Hive.box<Preset>(PresetsListBox.boxName);

    List<Preset?> presetsList = [];

    for (int i = 0; i < boxPresets.length; i++) {
      presetsList.add(boxPresets.getAt(i));
    }

    try {
      emit(
        PresetsRequestData(
          presets: presetsList,
        ),
      );
    } catch (err) {
      emit(const PresetsUnknownError());
    }
  }
}
