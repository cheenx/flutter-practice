import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gsy_github_app/common/config/config.dart';
import 'package:gsy_github_app/common/config/ignoreConfig.dart';
import 'package:gsy_github_app/common/dao/dao_result.dart';
import 'package:gsy_github_app/common/local/local_storage.dart';
import 'package:gsy_github_app/common/net/api.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';
import 'package:gsy_github_app/db/provider/user/userinfo_db_provider.dart';
import 'package:gsy_github_app/model/User.dart';
import 'package:gsy_github_app/redux/user_redux.dart';
import 'package:redux/redux.dart';

import '../net/Address.dart';

class UserDao {
  static oauth(code, store) async {
    httpManager.clearAuthorization();

    var res = await httpManager.netFetch(
        "https://github.com/login/oauth/access_token?"
        "client_id=${NetConfig.CLIENT_ID}"
        "&client_secret=${NetConfig.CLIENT_SECRET}"
        "&code=$code",
        null,
        null,
        Options(method: "POST"));

    dynamic resultData;
    if (res != null && res.result) {
      var result = Uri.parse("gsy://oauth?${res.data}");
      var token = result.queryParameters['access_token'];
      var token0 = "token $token";
      await LocalStorage.save(Config.TOKEN_KEY, token0);

      resultData = await getUserInfo(null);
      if (Config.DEBUG!) {
        if (kDebugMode) {
          print("user result ${resultData.result}");
          print(resultData.data);
          print(res.data.toString());
        }
      }
      if (resultData.result == true) {
        store.dispatch(UpdateUserAction(resultData.data));
      }
    }

    return DataResult(resultData, res?.result ?? false);
  }

  static login(userName, password, store) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);

    if (Config.DEBUG!) {
      if (kDebugMode) {
        print("base64Str login $base64Str");
      }
    }

    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };

    httpManager.clearAuthorization();

    var res = await httpManager.netFetch(Address.getAuthorization(),
        json.encode(requestParams), null, Options(method: "POST"));
    dynamic resultData;
    if (res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
      var resultData = await getUserInfo(null);
      if (Config.DEBUG!) {
        if (kDebugMode) {
          print("user result ${resultData.result}");
          print(resultData.data);
          print(res.data.toString());
        }
      }
      store.dispatch(UpdateUserAction(resultData.data));
    }
    return DataResult(resultData, res!.result);
  }

  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return DataResult(user, true);
    } else {
      return DataResult(null, false);
    }
  }

  static getUserInfo(userName, {needDb = false}) async {
    UserInfoDbProvider provider = UserInfoDbProvider();

    next() async {
      dynamic res;
      if (userName == null) {
        res = await httpManager.netFetch(
            Address.getMyUserInfo(), null, null, null);
      } else {
        res = await httpManager.netFetch(
            Address.getUserInfo(userName), null, null, null);
      }

      if (res != null && res.result) {
        String? starred = "---";
        if (res.data['type'] != "Organization") {
          var countRes = await getUserStarredCountNet(res.data['login']);
          if (countRes.result) {
            starred = countRes.data;
          }
        }
        User user = User.fromJson(res.data);
        user.starred = starred;

        if (userName == null) {
          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        }

        return DataResult(user, true);
      } else {
        return DataResult(res.data, false);
      }
    }

    if (needDb) {
      User? user = await provider.getUserInfo(userName);
      if (user == null) {
        return await next();
      }

      DataResult dataResult = DataResult(user, true, next: next);
      return dataResult;
    }

    return await next();
  }

  static getUserStarredCountNet(userName) async {
    String url = Address.userStar(userName, null) + "&per_page=1";
    var res = await httpManager.netFetch(url, null, null, null);
    if (res != null && res.result && res.headers != null) {
      try {
        StringList? link = res.headers['link'];
        if (link != null) {
          var [linkFirst] = link;
          int indexStart = linkFirst.lastIndexOf('page=') + 5;
          int indexEnd = linkFirst.lastIndexOf('>');
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = linkFirst.substring(indexStart, indexEnd);
            return DataResult(count, true);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return DataResult(null, false);
  }

  static clearAll(Store store) {
    httpManager.clearAuthorization();
    LocalStorage.remove(Config.USER_INFO);
    store.dispatch(UpdateUserAction(User.empty()));
  }
}
