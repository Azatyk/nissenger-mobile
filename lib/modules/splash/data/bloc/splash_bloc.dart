import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/splash/data/bloc/splash_event.dart';
import 'package:nissenger_mobile/modules/splash/data/bloc/splash_state.dart';
import 'package:nissenger_mobile/modules/splash/data/types/splash_status.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(
          const SplashState(status: SplashStatus.loading),
        ) {
    on<AppInitialized>(_onAppInitialized);
  }

  void _onAppInitialized(
    AppInitialized event,
    Emitter<SplashState> emit,
  ) async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.userSettingsBox);
    
    emit(const SplashState(
      status: SplashStatus.readyToPush,
    ));
  }
}
