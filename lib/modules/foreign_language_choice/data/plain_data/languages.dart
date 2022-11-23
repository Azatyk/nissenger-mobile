import 'package:nissenger_mobile/data/models/foreign_language.model.dart';

class MockForeignLanuages {
  static List<ForeignLanguage> getLanguages() {
    return const [
      ForeignLanguage(name: "Японский"),
      ForeignLanguage(name: "Корейский"),
      ForeignLanguage(name: "Корейский A2"),
      ForeignLanguage(name: "Немецкий A1"),
      ForeignLanguage(name: "Немецкий A2"),
      ForeignLanguage(name: "Французский начальный"),
      ForeignLanguage(name: "Французский А2"),
      ForeignLanguage(name: "Французский В1"),
      ForeignLanguage(name: "Китайский начальный"),
      ForeignLanguage(name: "Китайский продвинутый"),
    ];
  }
}
