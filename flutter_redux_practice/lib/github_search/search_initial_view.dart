import 'package:flutter/material.dart';

class SearchInitialView extends StatelessWidget {
  const SearchInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info,
            color: Colors.green[200],
            size: 80.0,
          ),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Enter a search term to begin',
              style: TextStyle(color: Colors.green[100]),
            ),
          )
        ],
      ),
    );
  }
}
