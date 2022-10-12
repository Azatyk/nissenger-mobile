import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/profiles_choose_cubit/data/types/profiles_choose_states.dart';

class ProfilesChooseRequestState extends Equatable {
  final ProfilesChooseStates profilesChooseState;

  const ProfilesChooseRequestState({
    required this.profilesChooseState,
  });

  @override
  List<Object?> get props => [
        profilesChooseState,
      ];
}