import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/greeting/data/cubit/greeting_state.dart';

class GreetingCubit extends Cubit<GreetingState> {
  GreetingCubit() : super(const GreetingPure());

  void chooseUserType({required String userType}) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.userType, userType);

    emit(GreetingReadyToPush(userType: userType));

    emit(const GreetingPure());
  }
}
