import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object?> get props => [];
}

class UserGlobalTypeChosen extends UserSettingsEvent {
  final String userType;

  const UserGlobalTypeChosen({
    required this.userType,
  });

  @override
  List<Object?> get props => [
        userType,
      ];
}
