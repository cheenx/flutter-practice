import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:gsy_github_app/common/net/code.dart';
import 'package:gsy_github_app/common/net/interceptors/error_interceptor.dart';
import 'package:gsy_github_app/common/net/interceptors/response_interceptor.dart';

import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/token_interceptor.dart';
import 'result_data.dart';

class HttpManager {
  static const CONNECT_TYPE_JSON = "application/json";
  static const CONNECT_TYPE_FORM = "application/x-www-form-urlencoded";

  final Dio _dio = Dio(); //使用默认配置

  final TokenInterceptors _tokenInterceptors = TokenInterceptors();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(LogInterceptors());
    _dio.interceptors.add(ErrorInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }

  Future<ResultData?> netFetch(
      url, params, Map<String, dynamic>? header, Options? option,
      {bool noTip = false}) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: 'get');
      option.headers = headers;
    }

    resultError(DioException e) {
      Response? errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(
            statusCode: 666, requestOptions: RequestOptions(path: url));
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorResponse!.statusCode = Code.NETWORK_TIMEOUT;
      }

      return ResultData(
          Code.errorHandleFunction(errorResponse!.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioException catch (e) {
      return resultError(e);
    }

    if (response.data is DioException) {
      return resultError(response.data);
    }

    return response.data;
  }

  /// 清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  /// 获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = HttpManager();
