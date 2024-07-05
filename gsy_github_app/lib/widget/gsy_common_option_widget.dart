import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../common/localization/default_localizations.dart';
import '../common/style/gsy_style.dart';
import '../common/utils/common_utils.dart';

/// Created by guoshuyu
/// Date: 2018-07-26
class GSYCommonOptionWidget extends StatelessWidget {
  final List<GSYOptionModel>? otherList;

  final String? url;

  const GSYCommonOptionWidget({super.key, this.otherList, String? url})
      : url = (url == null) ? GSYConstant.app_default_share_url : url;

  _renderHeaderPopItem(List<GSYOptionModel> list) {
    return PopupMenuButton<GSYOptionModel>(
      child: const Icon(GSYICons.MORE),
      onSelected: (model) {
        model.selected(model);
      },
      itemBuilder: (BuildContext context) {
        return _renderHeaderPopItemChild(list);
      },
    );
  }

  _renderHeaderPopItemChild(List<GSYOptionModel> data) {
    List<PopupMenuEntry<GSYOptionModel>> list = [];
    for (GSYOptionModel item in data) {
      list.add(PopupMenuItem<GSYOptionModel>(
        value: item,
        child: Text(item.name),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<GSYOptionModel> constList = [
      GSYOptionModel(GSYLocalizations.i18n(context)!.option_web,
          GSYLocalizations.i18n(context)!.option_web, (model) {
        CommonUtils.launchOutURL(url, context);
      }),
      GSYOptionModel(GSYLocalizations.i18n(context)!.option_copy,
          GSYLocalizations.i18n(context)!.option_copy, (model) {
        CommonUtils.copy(url ?? "", context);
      }),
      GSYOptionModel(GSYLocalizations.i18n(context)!.option_share,
          GSYLocalizations.i18n(context)!.option_share, (model) {
        Share.share(
            GSYLocalizations.i18n(context)!.option_share_title + (url ?? ""));
      }),
    ];
    var list = [...constList, ...?otherList];
    return _renderHeaderPopItem(list);
  }
}

class GSYOptionModel {
  final String name;
  final String value;
  final PopupMenuItemSelected<GSYOptionModel> selected;

  GSYOptionModel(this.name, this.value, this.selected);
}
