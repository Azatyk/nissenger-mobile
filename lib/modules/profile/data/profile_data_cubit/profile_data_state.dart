import 'package:equatable/equatable.dart';

abstract class ProfileDataState extends Equatable {
  const ProfileDataState();

  @override
  List<Object?> get props => [];
}

class ProfileDataPure extends ProfileDataState {
  const ProfileDataPure();
}

class ProfileData extends ProfileDataState {
  final String userType;
  final int? gradeNumber;
  final String? gradeLetter;
  final int? gradeGroup;
  final String? firstProfile;
  final String? secondProfile;
  final String? thirdProfile;
  final List<String>? foreignLanguages;

  final String? teacherName;

  const ProfileData({
    required this.userType,
    this.gradeNumber,
    this.gradeLetter,
    this.gradeGroup,
    this.firstProfile,
    this.secondProfile,
    this.thirdProfile,
    this.foreignLanguages,
    this.teacherName,
  });
}
