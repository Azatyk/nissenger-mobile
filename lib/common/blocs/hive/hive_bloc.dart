import 'package:flutter_bloc/flutter_bloc.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:nissenger_mobile/common/blocs/hive/hive_event.dart';
import 'package:nissenger_mobile/common/blocs/hive/hive_state.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';

class HiveBloc extends Bloc<HiveEvent, HiveState> {
  HiveBloc() : super(const HiveState()) {
    on<AppInitialized>(_onAppInitialized);
    add(const AppInitialized());
  }

  void _onAppInitialized(AppInitialized event, Emitter<HiveState> emit) async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.userSettingsBox);
  }
}
