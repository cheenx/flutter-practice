import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';

class JsonConvertTestRoute extends StatelessWidget {
  const JsonConvertTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Convert'),
      ),
      body: JsonConvertTest(),
    );
  }
}

class JsonConvertTest extends StatefulWidget {
  const JsonConvertTest({super.key});

  @override
  State<JsonConvertTest> createState() => _JsonConvertTestState();
}

class _JsonConvertTestState extends State<JsonConvertTest> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
          List items = json.decode(jsonStr);
          print(items[0]['name']);

          String jsonA = '{"name":"John Smith","email":"john@example.com"}';
          // Map<String, dynamic> user = json.decode(jsonA);

          Map<String, dynamic> userMap = json.decode(jsonA);
          var user = User.fromJson(userMap);

          print('Howdy, ${user.name}!');
          // print('We sent the verification link to ${user.email}.');
        },
        child: Text('convert'),
      ),
    );
  }
}
