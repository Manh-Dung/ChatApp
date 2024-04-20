import 'dart:convert';

import 'package:dio/dio.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode ?? 0;
    final uri = response.realUri;
    final data = jsonEncode(response.data ?? "");
    // print("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode ?? 0;
    final uri = err.response?.realUri;
    super.onError(err, handler);
  }
}
