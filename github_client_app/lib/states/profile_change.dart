import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widgets更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User? get user => _profile.user;

  //APP是否登录（如果有用户信息，则证明登录过）
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙widgets更新
  set user(User? user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  //获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500]!.value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  //获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale!.split('_');
    return Locale(t[0], t[1]);
  }

  //获取当前Locale的字符串表示
  String get locale => _profile.locale ?? '';

  set locale(String locale) {
    if (_profile != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
