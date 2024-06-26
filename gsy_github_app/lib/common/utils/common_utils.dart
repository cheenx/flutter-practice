import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/widget/gsy_flex_button.dart';

typedef StringList = List<String>;

class CommonUtils {
  static showLanguageDialog(BuildContext context) {
    StringList list = ["English", "简体中文"];

    CommonUtils.showCommitOptionDialog(context, list, (index) {},
        height: 150.0);
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
