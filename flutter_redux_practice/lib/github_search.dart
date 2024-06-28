import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_practice/epic/epic_middleware.dart';
import 'package:redux/redux.dart';

import 'github_search/search_epic.dart';
import 'github_search/search_reducer.dart';
import 'github_search/search_screen.dart';
import 'github_search/search_state.dart';

void main() {
  final store = Store<SearchState>(
    searchReducer,
    initialState: SearchInitial(),
    middleware: [
      /// 普通中间件 normal middleware
      // SearchMiddleware(GithubClient()),
      EpicMiddleware<SearchState>(loginEpic)
    ],
  );

  runApp(RxDartGithubSearchApp(
    store: store,
  ));
}

class RxDartGithubSearchApp extends StatelessWidget {
  final Store<SearchState>? store;
  const RxDartGithubSearchApp({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store!,
        child: MaterialApp(
          title: 'RxDart Github Search',
          theme: ThemeData(
              brightness: Brightness.dark, primarySwatch: Colors.grey),
          home: SearchScreen(),
        ));
  }
}
