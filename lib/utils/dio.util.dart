import 'package:dio/dio.dart';
import 'package:nissenger_mobile/config/config.dart';

class DioUtil {
  static Dio? _instance;

  static Dio getInstance() {
    _instance ??= createDioInstance();

    return _instance ?? Dio();
  }

  static Dio createDioInstance() {
    BaseOptions options = BaseOptions(
      baseUrl: Config.apiUrl,
    );

    var dio = Dio(options);

    return dio;
  }
}
