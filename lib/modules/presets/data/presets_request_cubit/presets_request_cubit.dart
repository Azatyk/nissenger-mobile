import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
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
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const PresetsInternetConnectionError());
      } else {
        emit(const PresetsUnknownError());
      }
    }
  }

  void deletePreset({required Preset? presetValue}) {
    var box = Hive.box<Preset>(PresetsListBox.boxName);

    Preset? preset = presetValue;

    late int indexOfPreset;

    for (var i = 0; i < box.length; i++) {
      if (box.getAt(i)!.gradeNumber == preset!.gradeNumber &&
          box.getAt(i)!.gradeLetter == preset.gradeLetter &&
          listEquals(box.getAt(i)!.foreignLanguages, preset.foreignLanguages) &&
          box.getAt(i)!.firstMainProfile == preset.firstMainProfile &&
          box.getAt(i)!.secondMainProfile == preset.secondMainProfile &&
          box.getAt(i)!.thirdProfile == preset.thirdProfile &&
          box.getAt(i)!.firstProfileGroup == preset.firstProfileGroup &&
          box.getAt(i)!.secondProfileGroup == preset.secondProfileGroup &&
          box.getAt(i)!.thirdProfileGroup == preset.thirdProfileGroup &&
          box.getAt(i)!.teacherName == preset.teacherName &&
          box.getAt(i)!.presetName == preset.presetName) {
        indexOfPreset = i;
        break;
      }
    }

    box.deleteAt(indexOfPreset);
  }
}
