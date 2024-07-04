import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/// Theme Redux
///
/// 通过定义flutter_redux的combineReducers,实现Reducer方法
final ThemeDataReducer = combineReducers<ThemeData?>([
  TypedReducer<ThemeData?, RefreshThemeDataAction>(_refresh),
]);

/// 定义处理Action行为的方法，返回新的state
ThemeData? _refresh(ThemeData? themeData, action) {
  themeData = action.themeData;
  return themeData;
}

/// 定义一个Action类
/// 将该Action在Reducer中与处理该Action的方法绑定
class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}
