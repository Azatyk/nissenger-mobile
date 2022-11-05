import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/splash/data/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(
          const SplashStateLoading(),
        );

  void initializeApp() async {
    await Hive.initFlutter();
    await Hive.openBox(UserSettingsBox.boxName);

    emit(
      const SplashStateReadyToPush(),
    );
  }
}
