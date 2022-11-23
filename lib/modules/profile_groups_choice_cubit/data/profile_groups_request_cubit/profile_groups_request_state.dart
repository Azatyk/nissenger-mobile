import 'package:equatable/equatable.dart';
import 'package:nissenger_mobile/data/models/profile_groups.model.dart';

abstract class ProfileGroupsRequestState extends Equatable {
  const ProfileGroupsRequestState();

  @override
  List<Object?> get props => [];
}

class ProfileGroupsRequestLoading extends ProfileGroupsRequestState {
  const ProfileGroupsRequestLoading();
}

class ProfileGroupsRequestError extends ProfileGroupsRequestState {
  const ProfileGroupsRequestError();
}

class ProfileGroupsRequestData extends ProfileGroupsRequestState {
  final List<ProfileGroups> profileGroups;

  const ProfileGroupsRequestData({required this.profileGroups});

  @override
  List<Object?> get props => [profileGroups];
}
