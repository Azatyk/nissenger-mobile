import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/types/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/greeting/data/cubit/greeting_state.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/greeting_status.type.dart';

class GreetingCubit extends Cubit<GreetingState> {
  GreetingCubit()
      : super(GreetingState(
          userType: UserTypes.pure,
          status: GreetingStatus.pure,
        ));

  void chooseUserType({required String userType}) {
    var box = Hive.box(HiveBoxes.userSettingsBox);
    box.put("type", userType);

    emit(
      GreetingState(
        userType: userType,
        status: GreetingStatus.readyToPush,
      ),
    );
  }
}
