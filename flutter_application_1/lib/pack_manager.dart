import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Words Rondom'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(wordPair.toString()),
        ),
      ),
    );
  }
}
