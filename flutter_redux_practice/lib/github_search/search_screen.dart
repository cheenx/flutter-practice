import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_practice/github_search/search_actions.dart';
import 'package:flutter_redux_practice/github_search/search_empty_view.dart';
import 'package:flutter_redux_practice/github_search/search_error_view.dart';
import 'package:flutter_redux_practice/github_search/search_initial_view.dart';
import 'package:flutter_redux_practice/github_search/search_loading_view.dart';
import 'package:flutter_redux_practice/github_search/search_result_view.dart';
import 'package:flutter_redux_practice/github_search/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, _SearchScreenViewModel>(
        builder: (context, _SearchScreenViewModel vm) {
      return Scaffold(
        body: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Search Github...'),
                style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Hind',
                    decoration: TextDecoration.none),
                onChanged: vm.onTextChanged,
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _buildVisible(vm.state),
              ),
            )
          ],
        ),
      );
    }, converter: (store) {
      return _SearchScreenViewModel(
          state: store.state,
          onTextChanged: (term) => store.dispatch(SearchAction(term)));
    });
  }

  _buildVisible(SearchState state) {
    print("state : $state");
    if (state is SearchLoading) {
      return SearchLoadingView();
    } else if (state is SearchEmpty) {
      return SearchEmptyView();
    } else if (state is SearchPopulated) {
      return SearchPopulatedView(
        result: state.result,
      );
    } else if (state is SearchInitial) {
      return SearchInitialView();
    } else if (state is SearchError) {
      return SearchErrorView();
    }

    throw ArgumentError('no view for state: $state');
  }
}

class _SearchScreenViewModel {
  final SearchState state;
  final void Function(String term) onTextChanged;

  _SearchScreenViewModel({required this.state, required this.onTextChanged});
}
