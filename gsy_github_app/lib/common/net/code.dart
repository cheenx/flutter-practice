import 'package:gsy_github_app/common/event/http_error_event.dart';
import 'package:gsy_github_app/common/event/index.dart';

/// 网络错误编码
class Code {
  /// 网络错误
  static const NETWORK_ERROR = -1;

  /// 网络超时
  static const NETWORK_TIMEOUT = -2;

  /// 网络返回数据格式化异常
  static const NETWORK_JSON_EXCEPTION = -3;

  /// Github api Connection refused
  static const GITHUB_API_REFUSED = -4;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    if (message != null &&
        message is String &&
        message.contains("Connection refused")) {
      code = GITHUB_API_REFUSED;
    }

    eventBus.fire(HttpErrorEvent(code, message));
    return message;
  }
}
