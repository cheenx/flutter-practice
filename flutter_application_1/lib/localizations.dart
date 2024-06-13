import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class DemoLocalizations {
//   DemoLocalizations(this.isZH);

//   //是否为中文
//   bool isZH = false;

//   //为了使用方便，我们定义一个静态方法
//   static DemoLocalizations? of(BuildContext context) {
//     return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
//   }

//   //Locale相关值，title为应用标题
//   String get title {
//     return isZH ? 'Flutter应用' : 'Flutter App';
//   }
// }

// class DemoLocalizationsDelegate
//     extends LocalizationsDelegate<DemoLocalizations> {
//   const DemoLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

//   @override
//   Future<DemoLocalizations> load(Locale locale) {
//     print('$locale');
//     return SynchronousFuture<DemoLocalizations>(
//         DemoLocalizations(locale.languageCode == 'zh'));
//   }

//   @override
//   bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations> old) =>
//       false;
// }


