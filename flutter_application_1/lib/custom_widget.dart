import 'package:flutter/material.dart';

class CustomeWidgetTestRoute extends StatelessWidget {
  const CustomeWidgetTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Widget Test')),
      body: TurnBoxTest(),
    );
  }
}

class TurnBoxTest extends StatefulWidget {
  const TurnBoxTest({super.key});

  @override
  State<TurnBoxTest> createState() => _TurnBoxTestState();
}

class _TurnBoxTestState extends State<TurnBoxTest> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(
              Icons.refresh,
              size: 50.0,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(
              Icons.refresh,
              size: 150.0,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
              child: const Text('顺时针旋转1/5圈')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
              child: const Text('逆时针旋转1/5圈')),
          MyRichText(
            text: '测试机c测试机c测试机c测试机c测试机chttp://www.baidu.com',
            linkStyle: TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}

class GradienButtonTest extends StatelessWidget {
  const GradienButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradienButton(
          child: const Text('Submit'),
          colors: const [Colors.orange, Colors.red],
          height: 50.0,
          onPressed: onTap,
        ),
        GradienButton(
          child: const Text('Submit'),
          colors: const [Colors.lightGreen, Colors.green],
          height: 50.0,
          onPressed: onTap,
        ),
        GradienButton(
          child: const Text('Submit'),
          colors: const [Colors.lightBlue, Colors.blueAccent],
          height: 50.0,
          onPressed: onTap,
        ),
      ],
    );
  }

  onTap() {
    print('button click');
  }
}

class GradienButton extends StatelessWidget {
  const GradienButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.onPressed,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final List<Color>? colors;

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  const TurnBox({Key? key, this.turns = .0, this.speed = 200, this.child})
      : super(key: key);

  final double turns;
  final int speed;
  final Widget? child;

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed),
          curve: Curves.easeOut);
    }
  }
}

class MyRichText extends StatefulWidget {
  const MyRichText({Key? key, this.text, this.linkStyle}) : super(key: key);

  final String? text;
  final TextStyle? linkStyle;

  @override
  State<MyRichText> createState() => _MyRichTextState();
}

class _MyRichTextState extends State<MyRichText> {
  late TextSpan _textSpan;

  @override
  void initState() {
    _textSpan = parseText(widget.text ?? '');
    super.initState();
  }

  TextSpan parseText(String text) {
    //耗时操作：解析文本字符串，构建出TextSpan
    int index = text.indexOf("http:");
    if (index < 0)
      return TextSpan(text: text, style: TextStyle(color: Colors.black));
    return TextSpan(text: text.substring(0, index), children: [
      TextSpan(text: text.substring(index), style: widget.linkStyle)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(_textSpan);
  }

  @override
  void didUpdateWidget(covariant MyRichText oldWidget) {
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text ?? '');
    }
    super.didUpdateWidget(oldWidget);
  }
}
