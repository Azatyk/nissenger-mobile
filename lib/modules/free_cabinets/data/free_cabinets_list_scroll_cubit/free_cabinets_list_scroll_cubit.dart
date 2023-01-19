import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/free_cabinets_list_scroll_cubit/free_cabinets_list_scroll_state.dart';

class FreeCabinetsListScrollCubit extends Cubit<FreeCabinetsListScrollState> {
  FreeCabinetsListScrollCubit()
      : super(
          const FreeCabinetsListScrollHideBorder(),
        );

  void scrollToBottom() {
    emit(
      const FreeCabinetsListScrollShowBorder(),
    );
  }

  void reachTop() {
    emit(
      const FreeCabinetsListScrollHideBorder(),
    );
  }
}
