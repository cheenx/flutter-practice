import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/dao/user_dao.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/redux/epic/epic_store.dart';
import 'package:gsy_github_app/redux/gsy_state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/// 登录相关 redux
final LoginReducer = combineReducers<bool?>([
  TypedReducer<bool?, LoginSuccessAction>(_loginResult),
  TypedReducer<bool?, LogoutAction>(_logoutResult),
]);

bool? _loginResult(bool? result, action) {
  if (action.success == true) {
    NavigatorUtils.goHome(action.context);
  }
  return action.success;
}

bool? _logoutResult(bool? result, action) {
  return true;
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

class LoginAction {
  final BuildContext context;
  final String? userName;
  final String? password;

  LoginAction(this.context, this.userName, this.password);
}

class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

class LoginMiddleware implements MiddlewareClass<GSYState> {
  @override
  call(Store<GSYState> store, action, NextDispatcher next) {
    if (action is LogoutAction) {
      UserDao.clearAll(store);
      // WebViewCookieManager().clearCookies();
      NavigatorUtils.goLogin(action.context);
    }

    next(action);
  }
}

Stream<dynamic> loginEpic(Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream<dynamic> loginIn(
      LoginAction action, EpicStore<GSYState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var nv = Navigator.of(action.context);
    var res = await UserDao.login(
        action.userName!.trim(), action.password!.trim(), store);
    nv.pop(action);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<LoginAction>()
      .switchMap((action) => loginIn(action, store));
}

Stream<dynamic> oauthEpic(Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream<dynamic> loginIn(
      OAuthAction action, EpicStore<GSYState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserDao.oauth(action.code, store);
    Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<OAuthAction>()
      .switchMap((action) => loginIn(action, store));
}
