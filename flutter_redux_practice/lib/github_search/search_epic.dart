import 'package:flutter_redux_practice/epic/epic.dart';
import 'package:flutter_redux_practice/epic/epic_store.dart';
import 'package:flutter_redux_practice/github_search/github_client.dart';
import 'package:flutter_redux_practice/github_search/search_actions.dart';
import 'package:flutter_redux_practice/github_search/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchEpic implements EpicClass<SearchState> {
  final GithubClient api;

  SearchEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<SearchState> store) {
    return actions
        //缩小搜索行动范围
        .whereType<SearchAction>()
        //在用户暂停 250 毫秒后才开始搜索
        .debounce((_) => TimerStream<void>(true, Duration(milliseconds: 250)))
        .switchMap<dynamic>((action) => _search(action.term!));
  }

  Stream<dynamic> _search(String term) async* {
    if (term.isEmpty) {
      yield SearchEmptyAction();
    } else {
      yield SearchLoadingAction();

      try {
        yield SearchResultAction(await api.search(term));
      } catch (e) {
        yield SearchErrorAction();
      }
    }
  }
}

//这种方式的实现比上面这中实现更简洁
Stream<dynamic> loginEpic(
    Stream<dynamic> actions, EpicStore<SearchState> store) {
  final api = GithubClient();

  Stream<dynamic> _search(String term) async* {
    if (term.isEmpty) {
      yield SearchEmptyAction();
    } else {
      yield SearchLoadingAction();

      try {
        yield SearchResultAction(await api.search(term));
      } catch (e) {
        yield SearchErrorAction();
      }
    }
  }

  return actions
      //缩小搜索行动范围
      .whereType<SearchAction>()
      //在用户暂停 250 毫秒后才开始搜索
      .debounce((_) => TimerStream<void>(true, Duration(milliseconds: 250)))
      .switchMap<dynamic>((action) => _search(action.term!));
}
