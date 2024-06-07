import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_checkbox.dart';
import 'package:flutter_application_1/widgets/done_widget.dart';

class CustomCheckBoxTestRoute extends StatelessWidget {
  const CustomCheckBoxTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Check Box Test')),
      body: CustomeCheckBoxTest(),
    );
  }
}

class CustomeCheckBoxTest extends StatefulWidget {
  const CustomeCheckBoxTest({super.key});

  @override
  State<CustomeCheckBoxTest> createState() => _CustomeCheckBoxTestState();
}

class _CustomeCheckBoxTestState extends State<CustomeCheckBoxTest> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCheckBox(
            value: _checked,
            onChanged: onChaned,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CustomCheckBox(
                strokeWidth: 1,
                radius: 1,
                value: _checked,
                onChanged: onChaned,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: CustomCheckBox(
              strokeWidth: 3,
              radius: 3,
              value: _checked,
              onChanged: onChaned,
              fillColor: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoneWidget(
                  outline: false,
                ),
                Text('操作成功'),
                DoneWidget(
                  outline: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onChaned(value) {
    setState(() {
      _checked = value;
    });
  }
}
