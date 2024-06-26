import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';
import 'package:gsy_github_app/widget/animated_background.dart';
import 'package:gsy_github_app/widget/gsy_flex_button.dart';
import 'package:gsy_github_app/widget/gsy_input_widget.dart';
import 'package:gsy_github_app/widget/particle/particle_widget.dart';

/// 登录页

class LoginPage extends StatefulWidget {
  static const String sName = "login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  String? _userName = "";
  String? _password = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              const Positioned(child: AnimatedBackground()),
              const Positioned.fill(child: ParticlesWidget(30)),
              Center(
                /// 防止overFlow的现象
                child: SafeArea(

                    /// 同时弹出键盘不遮挡
                    child: SingleChildScrollView(
                  child: Card(
                    elevation: 5.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: GSYColors.cardWhite,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                            image: AssetImage(GSYICons.DEFAULT_USER_ICON),
                            width: 90.0,
                            height: 90.0,
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          GSYInputWidget(
                            hintText: "github用户名，请不要用邮箱",
                            iconData: GSYICons.LOGIN_USER,
                            onChanged: (String value) {
                              _userName = value;
                            },
                            controller: userController,
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          GSYInputWidget(
                            hintText: "请输入密码",
                            iconData: GSYICons.LOGIN_PW,
                            obscureText: true,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: pwController,
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          SizedBox(
                            height: 50.0,
                            child: Row(
                              children: [
                                Expanded(
                                    child: GSYFlexButton(
                                  text: "账号登录",
                                  color: Theme.of(context).primaryColor,
                                  textColor: GSYColors.textWhite,
                                  fontSize: 16.0,
                                )),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                    child: GSYFlexButton(
                                  text: "安全登陆",
                                  color: Theme.of(context).primaryColor,
                                  textColor: GSYColors.textWhite,
                                  fontSize: 16.0,
                                )),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(15.0)),
                          InkWell(
                            onTap: () {
                              CommonUtils.showLanguageDialog(context);
                            },
                            child: const Text(
                              "切换语言",
                              style: TextStyle(color: GSYColors.subTextColor),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(15.0))
                        ],
                      ),
                    ),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
