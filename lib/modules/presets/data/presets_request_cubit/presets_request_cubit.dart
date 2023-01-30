import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_request_cubit/presets_request_state.dart';

class PresetsRequestCubit extends Cubit<PresetsRequestState> {
  PresetsRequestCubit() : super(const PresetsRequestPure());
}
