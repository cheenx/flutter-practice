import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app/common/config/config.dart';
import 'package:gsy_github_app/common/local/local_storage.dart';
import 'package:gsy_github_app/common/localization/default_localizations.dart';
import 'package:gsy_github_app/common/net/Address.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/common/utils/toast_utils.dart';
import 'package:gsy_github_app/redux/gsy_state.dart';
import 'package:gsy_github_app/redux/login_redux.dart';
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
  void initState() {
    super.initState();
    initParams();
  }

  void initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);

    userController.value = TextEditingValue(text: _userName ?? "");
    pwController.value = TextEditingValue(text: _password ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_userNameChange);
    pwController.removeListener(_passwordChange);
  }

  _userNameChange() {
    _userName = userController.text;
  }

  _passwordChange() {
    _password = pwController.text;
  }

  loginIn() async {
    if (_userName == null || _userName!.isEmpty) {
      ToastUtils.showToast(msg: "账户输入不正确");
      return;
    }

    if (_password == null || _password!.isEmpty) {
      ToastUtils.showToast(msg: "密码输入不正确");
      return;
    }

    ToastUtils.showToast(msg: GSYLocalizations.i18n(context)!.Login_deprecated);
  }

  oauthLogin() async {
    var st = StoreProvider.of<GSYState>(context);
    String? code = await NavigatorUtils.goLoginWebView(context,
        Address.getOAuthUrl(), GSYLocalizations.i18n(context)!.oauth_text);

    if (code != null && code.isNotEmpty) {
      /// 通过 redux 去执行登录流程
      ///
      st.dispatch(OAuthAction(context, code));
    }
  }

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
                            hintText: GSYLocalizations.i18n(context)!
                                .login_username_hint_text,
                            iconData: GSYICons.LOGIN_USER,
                            onChanged: (String value) {
                              _userName = value;
                            },
                            controller: userController,
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          GSYInputWidget(
                            hintText: GSYLocalizations.i18n(context)!
                                .login_password_hint_text,
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
                                  text: GSYLocalizations.i18n(context)!
                                      .login_text,
                                  color: Theme.of(context).primaryColor,
                                  textColor: GSYColors.textWhite,
                                  fontSize: 16.0,
                                  onPress: loginIn,
                                )),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                    child: GSYFlexButton(
                                  text: GSYLocalizations.i18n(context)!
                                      .oauth_text,
                                  color: Theme.of(context).primaryColor,
                                  textColor: GSYColors.textWhite,
                                  fontSize: 16.0,
                                  onPress: oauthLogin,
                                )),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(15.0)),
                          InkWell(
                            onTap: () {
                              CommonUtils.showLanguageDialog(context);
                            },
                            child: Text(
                              GSYLocalizations.i18n(context)!.switch_language,
                              style: const TextStyle(
                                  color: GSYColors.subTextColor),
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
