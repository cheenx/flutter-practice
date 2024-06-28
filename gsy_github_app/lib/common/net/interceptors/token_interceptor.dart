import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gsy_github_app/common/config/config.dart';
import 'package:gsy_github_app/common/local/local_storage.dart';
import 'package:gsy_github_app/common/net/graphql/client.dart';

/// Token拦截器
class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
        await initClient(_token);
      }
    }

    if (_token != null) {
      options.headers["Authorization"] = _token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token ${responseJson['token']}';
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return super.onResponse(response, handler);
  }

  /// 清楚授权
  clearAuthorization() {
    _token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
    releaseClient();
  }

  /// 获取授权token
  getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String? basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        /// 提示输入账号密码
      } else {
        /// 通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      _token = token;
      return token;
    }
  }
}
