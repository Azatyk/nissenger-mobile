import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/greeting/bloc/greeting_event.dart';
import 'package:nissenger_mobile/modules/greeting/bloc/greeting_state.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  GreetingBloc() : super(GreetingState()) {
    on<UserTypeChosen>(_onUserTypeChosen);
  }

  void _onUserTypeChosen(UserTypeChosen event, Emitter<GreetingState> emit) {
    // save user type
  }
}
