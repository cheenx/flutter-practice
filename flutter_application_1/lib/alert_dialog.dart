import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogTestRoute extends StatelessWidget {
  const AlertDialogTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog Test'),
      ),
      body: PageTest(),
    );
  }
}

class PageTest extends StatelessWidget {
  const PageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              bool? delete = await showDeleteConfirmDialog1(context);
              if (delete == null) {
                print('取消删除');
              } else {
                print('已确认删除');
              }
            },
            child: Text('对话框1')),
        ElevatedButton(
            onPressed: () {
              changeLanguage(context);
            },
            child: Text('对话框2')),
        ElevatedButton(
            onPressed: () {
              showListDialog(context);
            },
            child: Text('List对话框')),
        ElevatedButton(
            onPressed: () async {
              bool? deleteTree = await showDeleteConfirmDialog2(context);
              if (deleteTree == null) {
                print('取消删除');
              } else {
                print('同时删除子目录 ${deleteTree}');
              }
            },
            child: Text('对话框3(复选框可点击)')),
        ElevatedButton(
            onPressed: () async {
              int? type = await _showModalBottomSheet(context);
              print(type);
            },
            child: Text('显示底部菜单列表')),
        ElevatedButton(
            onPressed: () {
              showLoadingDialog(context);
            },
            child: Text('显示loading')),
        ElevatedButton(
            onPressed: () async {
              DateTime? date = await _showDatePicker2(context);
              print('${date}');
            },
            child: Text('日历选择器')),
      ],
    );
  }

  Future<bool?> showDeleteConfirmDialog1(BuildContext context) {
    return showCustomDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('您确定要删除当前文件吗？'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); //关闭对话框
                  },
                  child: Text('删除'))
            ],
          );
        });
  }

  Future<void> changeLanguage(BuildContext context) async {
    int? i = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('请选择语言'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美国英语'),
                ),
              ),
            ],
          );
        });
    if (i != null) {
      print("请选择了: ${i == 1 ? '中文简体' : '美国英语'}");
    }
  }

  Future<void> showListDialog(BuildContext context) async {
    int? index = await showDialog(
        context: context,
        builder: (context) {
          var child = Column(
            children: [
              const ListTile(
                title: Text('请选择'),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text('$index'),
                          onTap: () => Navigator.of(context).pop(index),
                        );
                      })))
            ],
          );
          // return Dialog(
          //   child: child,
          // );
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        });

    if (index != null) {
      print('点击了 $index');
    }
  }
}

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      final Widget pageChild = Builder(
        builder: builder,
      );
      return SafeArea(child: Builder(
        builder: (context) {
          return theme == null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        },
      ));
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x80000000),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class DialogCheckBox extends StatefulWidget {
  const DialogCheckBox({super.key, this.value, required this.onChanged});

  final ValueChanged<bool?> onChanged;
  final bool? value;

  @override
  State<DialogCheckBox> createState() => _DialogCheckBoxState();
}

class _DialogCheckBoxState extends State<DialogCheckBox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (v) {
          //将选中状态通过事件的形式抛出
          widget.onChanged(v);
          setState(() {
            value = v;
          });
        });
  }
}

Future<bool?> showDeleteConfirmDialog2(BuildContext context) {
  bool _withTree = false;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('您确定删除当前文件吗？'),
              Row(
                children: [
                  Text('同时删除子目录？'),
                  Builder(builder: (context) {
                    return Checkbox(
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                      value: _withTree,
                    );
                  })
                ],
              ),
              Row(
                children: [
                  Text('同时删除子目录？'),
                  StatefulBuilder(builder: (context, _setSate) {
                    return Checkbox(
                        value: _withTree,
                        onChanged: (value) {
                          _setSate(() {
                            _withTree = !_withTree;
                          });
                        });
                  })
                ],
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_withTree);
                },
                child: Text('删除'))
          ],
        );
      });
}

class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({Key? key, required this.builder})
      : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  State<StatefulBuilder> createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}

Future<int?> _showModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
            itemCount: 30,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text('$index'),
                onTap: () => Navigator.of(context).pop(index),
              );
            }));
      });
}

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 26.0),
                    child: Text('正在加载,请稍后...'),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Future<DateTime?> _showDatePicker1(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(days: 30)));
}

Future<DateTime?> _showDatePicker2(BuildContext context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(Duration(days: 30)),
              maximumYear: date.year + 1,
              onDateTimeChanged: (value) {
                print(value);
              }),
        );
      });
}
