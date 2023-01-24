import 'package:dio/dio.dart';

import 'package:nissenger_mobile/utils/dio.util.dart';

class FeatureToggleRequest {
  static Future getForeignLanguageToggle() async {
    Response res = await DioUtil.getInstance().get(
      "/features/",
    );

    return res;
  }
}
