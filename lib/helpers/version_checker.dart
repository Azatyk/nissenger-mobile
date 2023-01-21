import 'package:nissenger_mobile/config/config.dart';

class VersionChecker {
  static bool isVersionValid(
      {required int major, required int minor, required int patch}) {
    if (int.parse(Config.majorVersion) >= major) {
      if (int.parse(Config.minorVersion) >= minor) {
        if (int.parse(Config.patchVersion) >= patch) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
