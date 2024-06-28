import 'package:flutter_redux_practice/github_search/search_actions.dart';
import 'package:flutter_redux_practice/github_search/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchEmptyAction>(_onEmpty),
  TypedReducer<SearchState, SearchLoadingAction>(_onLoad),
  TypedReducer<SearchState, SearchErrorAction>(_onError),
  TypedReducer<SearchState, SearchResultAction>(_onResult),
]);

SearchState _onEmpty(SearchState state, SearchEmptyAction action) {
  return SearchInitial();
}

SearchState _onLoad(SearchState state, SearchLoadingAction action) {
  return SearchLoading();
}

SearchState _onError(SearchState state, SearchErrorAction action) {
  return SearchError();
}

SearchState _onResult(SearchState state, SearchResultAction action) {
  return action.result!.items!.isEmpty
      ? SearchEmpty()
      : SearchPopulated(action.result!);
}
