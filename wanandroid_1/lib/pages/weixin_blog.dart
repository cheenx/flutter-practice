import 'package:flutter/material.dart';

class WeixinPage extends StatefulWidget {
  const WeixinPage({super.key});

  @override
  State<WeixinPage> createState() => _WeixinPageState();
}

class _WeixinPageState extends State<WeixinPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('weixin public page.'),
    );
  }
}
