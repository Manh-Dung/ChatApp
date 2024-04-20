import 'package:dio/dio.dart';
import 'package:vinhcine/configs/app_config.dart';
import 'package:vinhcine/network/api_client.dart';

import 'api_interceptors.dart';
import 'logger_interceptor.dart';

class ApiUtil {
  static ApiClient getApiClient() {
    final dio = Dio();
    // dio.options.connectTimeout = Duration(milliseconds: 30000);
    dio.options.connectTimeout = 30000;
    dio.interceptors.addAll([ApiInterceptors(), PrettyDioLogger()]);
    final apiClient = ApiClient(dio, baseUrl: AppConfig.baseUrl);
    return apiClient;
  }
}
