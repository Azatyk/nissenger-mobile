import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/modules/profile_groups_choice_cubit/data/types/profile_groups_choice.dart';

class ProfileGroupsChoiceState extends Equatable {
  final GroupsChoiceState groupsChoiceState;
  final String firstGroup;
  final String secondGroup;
  final String thirdGroup;

  const ProfileGroupsChoiceState({
    required this.groupsChoiceState,
    required this.firstGroup,
    required this.secondGroup,
    required this.thirdGroup,
  });

  @override
  List<Object?> get props => [
        groupsChoiceState,
        firstGroup,
        secondGroup,
        thirdGroup,
      ];
}
