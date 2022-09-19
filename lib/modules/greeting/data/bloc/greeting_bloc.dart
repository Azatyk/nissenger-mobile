import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_event.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_state.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/greeting_status.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  GreetingBloc()
      : super(const GreetingState(
          status: GreetingStatus.pending,
        )) {
    on<UserTypeChosen>(_onUserTypeChosen);
  }

  void _onUserTypeChosen(
    UserTypeChosen event,
    Emitter<GreetingState> emit,
  ) {
    var box = Hive.box(HiveBoxes.userSettingsBox);

    box.put("type", event.userType);

    emit(const GreetingState(
      status: GreetingStatus.readyToPush,
    ));
  }
}
