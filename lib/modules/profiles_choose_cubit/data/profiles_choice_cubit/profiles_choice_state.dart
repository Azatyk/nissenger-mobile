import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/types/profiles_choose_states.dart';

class ProfilesChoiceState extends Equatable {
  final ProfilesStates profilesState;
  final String mainProfiles;
  final String thirdProfile;

  const ProfilesChoiceState({
    required this.profilesState,
    required this.mainProfiles,
    required this.thirdProfile,
  });

  @override
  List<Object?> get props => [
    profilesState,
    mainProfiles, 
    thirdProfile,
  ];
}
