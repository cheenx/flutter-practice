import 'package:flutter/material.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/states/profile_change.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  const ThemeChangeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes.map((e) {
          return GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: () {
              Provider.of<ThemeModel>(context, listen: false).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
