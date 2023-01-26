import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/sau_schedule/data/sau_schedule_request_cubit/sau_schedule_request_state.dart';

class SauScheduleRequestCubit extends Cubit<SauScheduleRequestState> {
  SauScheduleRequestCubit() : super(const SauScheduleRequestLoading()) {
    loadSauList();
  }

  void loadSauList() async {}
}
