import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTestRoute extends StatefulWidget {
  const DioTestRoute({super.key});

  @override
  State<DioTestRoute> createState() => _DioTestRouteState();
}

class _DioTestRouteState extends State<DioTestRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dio Test')),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              if (snapshot.hasError) {
                return Text('${snapshot.error.toString()}');
              }

              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(
                          title: Text(e['full_name']),
                        ))
                    .toList(),
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
