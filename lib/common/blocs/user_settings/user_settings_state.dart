import 'package:equatable/equatable.dart';

class UserSettingsState extends Equatable {
  final String userType;

  const UserSettingsState({
    required this.userType,
  });

  @override
  List<Object?> get props => [
        userType,
      ];
}
