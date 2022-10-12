import 'package:equatable/equatable.dart';

class ProfilesChooseFormState extends Equatable {
  final int mainProfiles;
  final int thirdProfile;

  const ProfilesChooseFormState({
    required this.mainProfiles,
    required this.thirdProfile,
  });

  @override
  List<Object?> get props => [
        mainProfiles,
        thirdProfile,
      ];

  ProfilesChooseFormState copyWith({int? mainProfiles, int? thirdProfile}) {
    return ProfilesChooseFormState(
      mainProfiles: mainProfiles ?? this.mainProfiles,
      thirdProfile: thirdProfile ?? this.thirdProfile,
    );
  }
}
