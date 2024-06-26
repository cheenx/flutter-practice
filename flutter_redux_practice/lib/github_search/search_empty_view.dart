import 'package:flutter/material.dart';

class SearchEmptyView extends StatelessWidget {
  const SearchEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: Colors.yellow[200],
            size: 80.0,
          ),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'No Results',
              style: TextStyle(color: Colors.yellow[100]),
            ),
          )
        ],
      ),
    );
  }
}
