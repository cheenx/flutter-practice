import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/git.dart';
import 'package:github_client_app/common/global.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/states/profile_change.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    //自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userName,
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: gm.password,
                    hintText: gm.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : gm.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: Text(gm.login),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    //先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User? user;

      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);
        //因为登录页面返回后，首页会build，所以我们传入false，这样更新user会便不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioError catch (e) {
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPaddwordWrong);
        } else {
          showToast(e.toString());
        }
      } finally {
        Navigator.of(context).pop();
      }
      //登录成功则返回
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
