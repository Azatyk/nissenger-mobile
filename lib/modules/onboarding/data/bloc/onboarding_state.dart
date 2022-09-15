import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final String title;
  final String subtitle;
  final String imageName;
  final bool lastSlide;

  const OnboardingState({
    required this.title,
    required this.subtitle,
    required this.imageName,
    required this.lastSlide,
  });

  @override
  List<Object?> get props => [];

  OnboardingState copyWith({
    String? title,
    String? subtitle,
    String? imageName,
    bool? lastSlide,
  }) {
    return OnboardingState(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageName: imageName ?? this.imageName,
      lastSlide: lastSlide ?? this.lastSlide,
    );
  }
}
