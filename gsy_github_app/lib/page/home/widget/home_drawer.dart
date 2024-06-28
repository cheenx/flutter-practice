import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/widget/gsy_flex_button.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
              child: Material(
                color: GSYColors.white,
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        "----",
                        style: GSYConstant.largeTextWhite,
                      ),
                      accountEmail: Text(
                        "****",
                        style: GSYConstant.normalTextLight,
                      ),
                      currentAccountPicture: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(GSYICons.DEFAULT_REMOTE_PIC),
                        ),
                      ),
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                    ),
                    ListTile(
                      title: Text(
                        "问题反馈",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "阅读历史",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "个人信息",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "切换主题",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "语言切换",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "灰度 App",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "检测更新",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "关于",
                        style: GSYConstant.normalText,
                      ),
                    ),
                    ListTile(
                      title: GSYFlexButton(
                        text: "退出登录",
                        color: Colors.redAccent,
                        textColor: GSYColors.textWhite,
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
