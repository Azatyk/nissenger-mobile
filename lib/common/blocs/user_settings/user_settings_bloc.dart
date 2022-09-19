import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/blocs/user_settings/user_settings_event.dart';
import 'package:nissenger_mobile/common/blocs/user_settings/user_settings_state.dart';
import 'package:nissenger_mobile/common/types/user_types.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc()
      : super(UserSettingsState(
          userType: UserTypes.pure,
        )) {
    on<UserGlobalTypeChosen>(_onUserTypeChosen);
  }

  void _onUserTypeChosen(
    UserGlobalTypeChosen event,
    Emitter<UserSettingsState> emit,
  ) {
    if (event.userType == UserTypes.teacher) {
      emit(UserSettingsState(
        userType: UserTypes.teacher,
      ));
    } else if (event.userType == UserTypes.student) {
      emit(UserSettingsState(
        userType: UserTypes.student,
      ));
    }
  }
}
