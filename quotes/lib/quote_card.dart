import 'package:flutter/material.dart';
import 'package:quotes/quote.dart';

class QuoteCard extends StatelessWidget {
  
  final Quote quote;
  
  //类型类Function() 
  final VoidCallback delete;

  const QuoteCard({super.key, required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${quote.text}',
              style: TextStyle(color: Colors.grey[600], fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${quote.author}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: (){
                delete();
              },
              child: Row(
                children: [Icon(Icons.delete), Text('delete quote')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
