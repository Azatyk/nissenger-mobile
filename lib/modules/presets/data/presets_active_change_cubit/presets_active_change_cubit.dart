import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_active_change_cubit/presets_active_change_state.dart';

class PresetsActiveChangeCubit extends Cubit<PresetsActiveChangeState> {
  PresetsActiveChangeCubit() : super(const PresetsActiveChangeState());

  void changeActive() {}
}
