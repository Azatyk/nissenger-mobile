import 'package:equatable/equatable.dart';

class ProfileGroupChoiceFormState extends Equatable {
  final int firstGroup;
  final int secondGroup;
  final int thirdGroup;

  const ProfileGroupChoiceFormState({
    required this.firstGroup,
    required this.secondGroup,
    required this.thirdGroup,
  });

  @override
  List<Object?> get props => [
        firstGroup, 
        secondGroup, 
        thirdGroup,
      ];

  ProfileGroupChoiceFormState copyWith({int? firstGroup, int? secondGroup, int? thirdGroup}) {
    return ProfileGroupChoiceFormState(
      firstGroup: firstGroup ?? this.firstGroup, 
      secondGroup: secondGroup ?? this.secondGroup, 
      thirdGroup: thirdGroup ?? this.thirdGroup,     
    );
  }
}
