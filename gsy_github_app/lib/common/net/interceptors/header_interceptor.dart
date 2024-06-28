import 'package:dio/dio.dart';

/// Header拦截器
///
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    super.onRequest(options, handler);
  }
}
