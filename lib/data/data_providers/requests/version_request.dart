import 'package:dio/dio.dart';

import 'package:nissenger_mobile/utils/dio.util.dart';

class VersionRequests {
  static Future getAppVersion() async {
    Response res = await DioUtil.getInstance().get(
      "/version/",
    );

    return res;
  }
}
