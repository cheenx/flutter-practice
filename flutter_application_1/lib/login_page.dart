import 'package:flutter/material.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: FormTestRoute(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _unameController;
  late TextEditingController _pwdController;
  FocusNode emailFocusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _unameController = TextEditingController();
    _unameController.addListener(() {
      print(_unameController.text);
    });

    _pwdController = TextEditingController();
    _pwdController.addListener(() {
      print(_pwdController.text);
    });

    emailFocusNode.addListener(() {
      _handleUnderLineFocus(emailFocusNode.hasFocus);
    });
  }

  void _handleUnderLineFocus(bool hasFocus) {
    setState(() {
      _focused = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.grey[200],
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0))),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: const InputDecoration(
                      labelText: '用户名',
                      hintText: '用户名或邮箱',
                      prefixIcon: Icon(Icons.person)),
                ),
                TextField(
                  controller: _pwdController,
                  decoration: const InputDecoration(
                      labelText: '密码',
                      hintText: '您的登录密码',
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                )
              ],
            )),
        Container(
          child: TextField(
            focusNode: emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: '电子邮件地址',
                prefixIcon: Icon(Icons.email),
                border: InputBorder.none //隐藏下划线
                ),
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _focused ? Colors.purple : Colors.grey,
                      width: 1.5))),
        )
      ],
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  State<FocusTestRoute> createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      print('input1 has focus : ${focusNode1.hasFocus}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            focusNode: focusNode1,
            decoration: const InputDecoration(
              labelText: 'input1',
            ),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: const InputDecoration(labelText: 'input2'),
          ),
          Builder(builder: (context) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      //将焦点从第一个TextField移动到第二个TextField
                      //这种写法FocusScope.of(context).requestFocus(focusNode2);

                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode?.requestFocus(focusNode2);
                    },
                    child: Text('移动焦点')),
                ElevatedButton(
                    onPressed: () {
                      //当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                    child: Text('隐藏键盘')),
              ],
            );
          })
        ],
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: _unameController,
            decoration: InputDecoration(
                labelText: '用户名', hintText: '用户名或邮箱', icon: Icon(Icons.person)),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : '用户名不能为空';
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: InputDecoration(
                labelText: '密码', hintText: '您的登录密码', icon: Icon(Icons.lock)),
            obscureText: true,
            validator: (v) {
              return v!.trim().length > 5 ? null : '密码不能少于6位';
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          //通过_formKey.currentState 获取FormState后,
                          //调用validate()方法校验用户名密码是否合法，校验
                          //通过后在提交数据
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            print(
                                'uname : ${_unameController.text} pwd : ${_pwdController.text}');
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('登录'),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
