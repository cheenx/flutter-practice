import 'package:flutter/material.dart';
import 'package:gsy_github_app/model/User.dart';
import 'package:gsy_github_app/redux/epic/epic_middleware.dart';
import 'package:gsy_github_app/redux/login_redux.dart';
import 'package:redux/redux.dart';

import 'grey_redux.dart';
import 'locale_redux.dart';
import 'theme_redux.dart';
import 'user_redux.dart';

/// 全局Redux store对象，保存State数据
class GSYState {
  /// 用户信息
  User? userInfo;

  /// 主题数据
  ThemeData? themeData;

  /// 语言
  Locale? locale;

  /// 当前手机平台默认语言
  Locale? platformLocale;

  /// 是否登录
  bool? login;

  /// 是否变成灰色
  bool grey;

  /// 构造方法
  GSYState(
      {this.userInfo,
      this.themeData,
      this.locale,
      this.login,
      this.grey = false});
}

/// 创建appReducer
/// 源码中 Reducer 是一个方法 typedef state Reducer<State>(State state,dynamic action)
/// 我们定义了 appReducer 用于创建 store
///
GSYState appReducer(GSYState state, action) {
  return GSYState(
    /// 通过UserReducer 将GSYState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    /// 通过ThemeDataReducer 将GSYState 内的locale 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

    /// 通过LocaleReducer 将GSYState 内的locale 和 action关联在一起
    locale: LocaleReducer(state.locale, action),
    login: LoginReducer(state.login, action),

    /// 通过GreyReducer 将GSYState 内的 grey 和 action 关联在一起
    grey: GreyReducer(state.grey, action),
  );
}

final List<Middleware<GSYState>> middlewares = [
  EpicMiddleware<GSYState>(loginEpic),
  EpicMiddleware<GSYState>(userInfoEpic),
  EpicMiddleware<GSYState>(oauthEpic),
  UserInfoMiddleware(),
  LoginMiddleware(),
];
