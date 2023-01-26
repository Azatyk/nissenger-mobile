import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/sau_schedule/data/sau_schedule_request_cubit/sau_schedule_request_state.dart';

class SauScheduleRequestCubit extends Cubit<SauScheduleRequestState> {
  SauScheduleRequestCubit() : super(const SauScheduleRequestData()) {
    loadSauList();
  }

  void loadSauList() async {}
}
