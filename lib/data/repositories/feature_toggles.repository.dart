import 'package:dio/dio.dart';

import 'package:nissenger_mobile/data/data_providers/requests/feature_toggle_requests.dart';
import 'package:nissenger_mobile/data/models/feature_toggle.model.dart';

class FeatureTogglesRepository {
  FeatureTogglesRepository();

  Future getForeignLanguageToggle() async {
    Response res = await FeatureToggleRequest.getForeignLanguageToggle();

    return FeatureToggle.fromJson(json: res.data);
  }
}
