import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/relogin/data/relogin_cubit/relogin_state.dart';

class ReloginCubit extends Cubit<ReloginState> {
  ReloginCubit() : super(const ReloginState());

  logout() {
    var box = Hive.box(UserSettingsBox.boxName);
    box.deleteAll(box.keys);
  }
}
