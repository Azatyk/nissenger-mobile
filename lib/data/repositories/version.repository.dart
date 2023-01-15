import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/requests/version_request.dart';
import 'package:nissenger_mobile/data/models/version.model.dart';

class VersionRepository {
  VersionRepository();

  Future getAppVersion() async {
    Response res = await VersionRequests.getAppVersion();

    return Version.fromJson(json: res.data);
  }
}
