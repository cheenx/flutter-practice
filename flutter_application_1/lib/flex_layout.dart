import 'package:flutter/material.dart';

class FlexLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flex Layout Test'),
        backgroundColor: Colors.blue,
      ),
      body: FlexTest(),
    );
  }
}

class FlexTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  height: 30.0,
                  color: Colors.green,
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100.0,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 30.0,
                      color: Colors.red,
                    )),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.green,
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
