import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter_redux_practice/github_search/search_actions.dart';
import 'package:flutter_redux_practice/github_search/search_state.dart';
import 'package:redux/redux.dart';

import 'github_client.dart';

class SearchMiddleware implements MiddlewareClass<SearchState> {
  final GithubClient api;
  Timer? _timer;

  CancelableOperation<Store<SearchState>>? _operation;
  SearchMiddleware(this.api);

  @override
  void call(Store<SearchState> store, action, NextDispatcher next) {
    if (action is SearchAction) {
      // Stop our previous debounce timer and search.
      _timer?.cancel();
      _operation?.cancel();

      // Don't start searching until the user pauses for 250ms. This will stop
      // us from over-fetching from our backend.
      _timer = Timer(Duration(milliseconds: 250), () {
        if (action.term!.isEmpty) {
          store.dispatch(SearchEmptyAction());
        } else {
          store.dispatch(SearchLoadingAction());

          // Instead of a simple Future, we'll use a CancellableOperation from the
          // `async` package. This will allow us to cancel the previous operation
          // if a Search term comes in. This will prevent us from
          // accidentally showing stale results.
          _operation = CancelableOperation.fromFuture(api
              .search(action.term!)
              .then((result) => store..dispatch(SearchResultAction(result)))
              .catchError((Object e, StackTrace s) =>
                  store..dispatch(SearchErrorAction())));
        }
      });
    }

    print("action: $action");

    next(action);
  }
}
