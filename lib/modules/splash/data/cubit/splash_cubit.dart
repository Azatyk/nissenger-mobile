import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(
          const SplashStateLoading(),
        );

  void initializeApp() async {
    await Hive.initFlutter();
    var box = await Hive.openBox(UserSettingsBox.boxName);

    if (box.containsKey(UserSettingsBox.userType)) {
      String activeAppMode = box.get(UserSettingsBox.activeAppMode);

      if (activeAppMode == AppModes.schedule) {
        emit(
          const SplashStateReadyToPush(
            authorized: true,
            mode: AppModes.schedule,
          ),
        );
      } else if (activeAppMode == AppModes.timer) {
        emit(
          const SplashStateReadyToPush(
            authorized: true,
            mode: AppModes.timer,
          ),
        );
      }
    } else {
      emit(
        const SplashStateReadyToPush(authorized: false),
      );
    }
  }
}
