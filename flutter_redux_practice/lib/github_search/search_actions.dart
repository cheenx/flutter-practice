import 'package:flutter_redux_practice/github_search/search_result.dart';

class SearchAction {
  final String? term;

  SearchAction(this.term);
}

class SearchEmptyAction {}

class SearchLoadingAction {}

class SearchErrorAction {}

class SearchResultAction {
  final SearchResult? result;

  SearchResultAction(this.result);
}
