import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_user_type_cubit/schedule_user_type_state.dart';

class ScheduleUserTypeCubit extends Cubit<ScheduleUserTypeState> {
  ScheduleUserTypeCubit()
      : super(ScheduleUserTypeState(userType: UserTypes.pure));

  void getUserType() {
    var box = Hive.box(UserSettingsBox.boxName);
    String userType = box.get(UserSettingsBox.userType);

    emit(ScheduleUserTypeState(userType: userType));
  }
}
