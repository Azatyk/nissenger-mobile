import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/config/config.dart';
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

    final newVersion = NewVersionPlus(
      iOSId: Config.iosAppID,
      androidId: Config.androidAppID,
    );
    final status = await newVersion.getVersionStatus();
    final bool update = status!.canUpdate;

    if (!box.containsKey(UserSettingsBox.city)) {
      box.put(UserSettingsBox.city, Config.requestCity);
      box.put(UserSettingsBox.school, Config.requestSchool);
    }

    if (box.containsKey(UserSettingsBox.userType)) {
      String activeAppMode = box.get(UserSettingsBox.activeAppMode) ?? "";

      if (activeAppMode == AppModes.schedule) {
        emit(
          SplashStateReadyToPush(
            authorized: true,
            update: update,
            mode: AppModes.schedule,
          ),
        );
      } else if (activeAppMode == AppModes.timer) {
        emit(
          SplashStateReadyToPush(
            authorized: true,
            update: update,
            mode: AppModes.timer,
          ),
        );
      } else {
        emit(
          SplashStateReadyToPush(
            authorized: false,
            update: update,
          ),
        );
      }
    } else {
      emit(
        SplashStateReadyToPush(
          authorized: false,
          update: update,
        ),
      );
    }
  }
}
