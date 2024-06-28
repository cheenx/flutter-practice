import 'package:flutter_redux_practice/github_search/search_result.dart';

abstract class SearchState {}

class SearchInitial implements SearchState {}

class SearchLoading implements SearchState {}

class SearchEmpty implements SearchState {}

class SearchPopulated implements SearchState {
  final SearchResult result;
  SearchPopulated(this.result);
}

class SearchError implements SearchState {}
