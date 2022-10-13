import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/profile_group_choice_cubit/data/types/profile_group_choice_state.dart';

class ProfileGroupChoiceRequestState extends Equatable {
  final ProfileGroupChoiceState profileGroupChoiceState;

  const ProfileGroupChoiceRequestState({
    required this.profileGroupChoiceState,
  });

  @override
  List<Object?> get props => [
        profileGroupChoiceState,
      ];
}