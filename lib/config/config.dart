import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String apiUrl = dotenv.env["API_URL"] ?? "";
  static String requestCity = dotenv.env["REQUEST_CITY"] ?? "";
  static String requestSchool = dotenv.env["REQUEST_SCHOOL"] ?? "";
  static String appMetricaKey = dotenv.env["APP_METRICA_KEY"] ?? "";
  static String androidAppID = dotenv.env["ANDROID_APPLICATION_ID"] ?? "";
  static String iosAppID = dotenv.env["IOS_APPLICATION_ID"] ?? "";
}
