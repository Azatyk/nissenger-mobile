import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String apiUrl = dotenv.env["API_URL"] ?? "";
}
