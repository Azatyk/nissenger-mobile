class FeatureToggle {
  final bool isEnabled;

  const FeatureToggle({required this.isEnabled});

  factory FeatureToggle.fromJson({required Map<String, dynamic> json}) {
    return FeatureToggle(isEnabled: json[""]);
  }
}
