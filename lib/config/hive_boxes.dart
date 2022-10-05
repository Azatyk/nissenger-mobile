class HiveBox {
  String boxName = "";
}

class UserSettingsBox implements HiveBox {
  @override
  String boxName = "user_settings";

  static const typeKey = "type";
}
