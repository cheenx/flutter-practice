import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gsy_github_app/common/config/config.dart';
import 'package:gsy_github_app/common/local/local_storage.dart';
import 'package:gsy_github_app/common/localization/default_localizations.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/common/utils/toast_utils.dart';
import 'package:gsy_github_app/redux/gsy_state.dart';
import 'package:gsy_github_app/redux/locale_redux.dart';
import 'package:gsy_github_app/widget/gsy_flex_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

typedef StringList = List<String>;

class CommonUtils {
  static Locale? curLocale;

  static copy(String? data, BuildContext context) {
    if (data != null) {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtils.showToast(
          msg: GSYLocalizations.i18n(context)!.option_share_copy_success);
    }
  }

  static launchOutURL(String? url, BuildContext context) async {
    var gl = GSYLocalizations.i18n(context);
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ToastUtils.showToast(
          msg: "${gl!.option_web_launcher_error} : ${url ?? ""}");
    }
  }

  static showLanguageDialog(BuildContext context) {
    StringList list = [
      GSYLocalizations.i18n(context)!.home_language_default,
      GSYLocalizations.i18n(context)!.home_language_zh,
      GSYLocalizations.i18n(context)!.home_language_en,
    ];

    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeLocale(StoreProvider.of<GSYState>(context), index);
      LocalStorage.save(Config.LOCALE, index.toString());
    }, height: 150.0);
  }

  static changeLocale(Store<GSYState> store, int index) {
    Locale? locale = store.state.platformLocale;
    if (Config.DEBUG!) {
      if (kDebugMode) {
        print(store.state.platformLocale);
      }
    }
    switch (index) {
      case 1:
        locale = const Locale('zh', 'CH');
        break;
      case 2:
        locale = const Locale('en', 'US');
        break;
    }
    curLocale = locale;
    store.dispatch(RefreshLocaleAction(locale));
  }

  static getThemeDate(Color color) {
    return ThemeData(

        /// 用来适配 Theme.of(context).primaryColorLight 和 primaryColorDark 的颜色变化，不设置可能会是默认蓝色
        primarySwatch: color as MaterialColor,

        /// Card 在M3下，会有apply OverLay
        colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            primary: color,
            brightness: Brightness.light,

            /// 影响 card 的表色，因为M3下是 applySurfaceTint, 在Material里
            surfaceTint: Colors.transparent),
        iconTheme: const IconThemeData(
            size: 24.0,
            fill: 0.0,
            weight: 400.0,
            grade: 0.0,
            opticalSize: 48.0,
            color: Colors.white,
            opacity: 0.8),

        /// 修改 FloatingActionButton的默认主题行为
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: color,
            shape: const CircleBorder()),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white, size: 24.0),
            backgroundColor: color,
            titleTextStyle: Typography.dense2021.titleLarge,
            systemOverlayStyle: SystemUiOverlayStyle.light),

        ///如果需要去除对应的水波纹效果
        splashFactory: NoSplash.splashFactory,
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(splashFactory: NoSplash.splashFactory)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(splashFactory: NoSplash.splashFactory)));
  }

  static getApplicationDocumentsPath() async {
    Directory appDir;
    if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      appDir = await getApplicationSupportDirectory();
    }

    String appDocPath = "${appDir.path}/gsygithubapp";
    Directory appPath = Directory(appDocPath);
    await appPath.create(recursive: true);
    return appPath.path;
  }

  static Future<void> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: PopScope(
              canPop: false,
              child: Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitCubeGrid(
                        color: GSYColors.white,
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        GSYLocalizations.i18n(context)!.loading_text,
                        style: GSYConstant.normalTextWhite,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static Future<void> showCommitOptionDialog(
      BuildContext context, List<String?>? commitMaps, ValueChanged<int> onTap,
      {width = 250.0, height = 400.0, List<Color>? colorList}) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: GSYColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: ListView.builder(
                  itemCount: commitMaps?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GSYFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null
                          ? colorList[index]
                          : Theme.of(context).primaryColor,
                      text: commitMaps![index],
                      textColor: GSYColors.white,
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }
}
