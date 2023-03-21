import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/config/config.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/data/models/version.model.dart';
import 'package:nissenger_mobile/data/repositories/version.repository.dart';
import 'package:nissenger_mobile/helpers/version_checker.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  VersionRepository repository;

  SplashCubit({required this.repository})
      : super(
          const SplashStateLoading(),
        );

  void initializeApp() async {
    emit(const SplashStateLoading());

    await Hive.initFlutter();
    var box = await Hive.openBox(UserSettingsBox.boxName);
    await Hive.openBox<Preset>(PresetsListBox.boxName);
    await Hive.openBox<Preset?>(ActivePresetBox.boxName);

    late Version version;

    try {
      version = await repository.getAppVersion();
      final int major = version.major;
      final int minor = version.minor;
      final int patch = version.patch;

      if (!box.containsKey(UserSettingsBox.city)) {
        box.put(UserSettingsBox.city, Config.requestCity);
        box.put(UserSettingsBox.school, Config.requestSchool);
      }

      if (VersionChecker.isVersionValid(
          major: major, minor: minor, patch: patch)) {
        emit(const SplashStateUpdateRequired());
      } else if (box.containsKey(UserSettingsBox.userType)) {
        String activeAppMode = box.get(UserSettingsBox.activeAppMode) ?? "";

        if (activeAppMode == AppModes.schedule) {
          emit(
            const SplashStateReadyToPush(mode: AppModes.schedule),
          );
        } else if (activeAppMode == AppModes.timer) {
          emit(
            const SplashStateReadyToPush(mode: AppModes.timer),
          );
        } else {
          emit(const SplashStateUnauthorized());
        }
      } else {
        emit(const SplashStateUnauthorized());
      }
    } catch (error) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const SplashStateInternetConnectionError());
      } else {
        emit(const SplashStateUnknownError());
      }
    }
  }
}
