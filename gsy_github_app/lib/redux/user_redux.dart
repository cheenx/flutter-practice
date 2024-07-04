import 'package:flutter/foundation.dart';
import 'package:gsy_github_app/common/dao/user_dao.dart';
import 'package:gsy_github_app/model/User.dart';
import 'package:gsy_github_app/redux/epic/epic_store.dart';
import 'package:gsy_github_app/redux/gsy_state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 用户相关Redux
 */

/// redux的combineReducers，通过TypedReducer将UpdateUserAction 与 reducers 关联起来
final UserReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateLoaded),
]);

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateLoaded
/// _updateLoaded这里接受一个新的userInfo，并返回
User? _updateLoaded(User? user, action) {
  user = action.userInfo;
  return user;
}

/// 定义一个UpdateUserAction，用于发起userInfo的改变
/// 类名随意定义，只要通过上面TypeReducer绑定就好
class UpdateUserAction {
  final User? userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUseAction {}

class UserInfoMiddleware implements MiddlewareClass<GSYState> {
  @override
  call(Store<GSYState> store, action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      if (kDebugMode) {
        print("******************  UserInfoMiddleware  ******************");
      }
    }

    next(action);
  }
}

Stream<dynamic> userInfoEpic(
    Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream<dynamic> loadUserInfo() async* {
    if (kDebugMode) {
      print(
          "******************  userInfoEpic _loadUserInfo ******************");
    }

    var res = await UserDao.getUserInfo(null);
    yield UpdateUserAction(res.data);
  }

  return actions
      .whereType<FetchUseAction>()
      .debounce((_) => TimerStream(true, const Duration(milliseconds: 10)))
      .switchMap((action) => loadUserInfo());
}
