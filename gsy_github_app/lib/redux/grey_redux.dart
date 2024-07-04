import 'package:redux/redux.dart';

final GreyReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshGreyAction>(_refresh),
]);

bool _refresh(bool grey, action) {
  return action.grey;
}

class RefreshGreyAction {
  final bool grey;

  RefreshGreyAction(this.grey);
}
