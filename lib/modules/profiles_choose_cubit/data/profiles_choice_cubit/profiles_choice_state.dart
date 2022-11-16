import 'package:equatable/equatable.dart';

class ProfilesChoiceState extends Equatable {
  const ProfilesChoiceState();

  @override
  List<Object?> get props => [];
}

class ProfilesChoiceData extends ProfilesChoiceState {
  final String mainProfiles;
  final String thirdProfiles;

  const ProfilesChoiceData({
    required this.mainProfiles,
    required this.thirdProfiles,
  });

  @override
  List<Object?> get props => [
        mainProfiles,
        thirdProfiles,
      ];
}

class ProfilesChoiceReadyToPush extends ProfilesChoiceState {
  const ProfilesChoiceReadyToPush();
}
