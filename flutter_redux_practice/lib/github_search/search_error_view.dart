import 'package:flutter/material.dart';

class SearchErrorView extends StatelessWidget {
  const SearchErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[300],
            size: 80.0,
          ),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Rate limit exceeded',
              style: TextStyle(color: Colors.red[300]),
            ),
          )
        ],
      ),
    );
  }
}
