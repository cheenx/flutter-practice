import 'package:flutter/material.dart';

class SearchLoadingView extends StatelessWidget {
  const SearchLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}
