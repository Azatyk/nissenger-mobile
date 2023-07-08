import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/presets/data/presets_scroll_cubit/presets_scroll_state.dart';

class PresetsScrollCubit extends Cubit<PresetsScrollState> {
  PresetsScrollCubit()
      : super(
          const PresetsScrollHideBorder(),
        );

  void scrollToBottom() {
    emit(
      const PresetsScrollShowBorder(),
    );
  }

  void reachTop() {
    emit(
      const PresetsScrollHideBorder(),
    );
  }
}
