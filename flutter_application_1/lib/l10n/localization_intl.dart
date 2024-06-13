import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);

    return initializeMessages(localName).then((b) {
      Intl.defaultLocale = localName;
      return DemoLocalizations();
    });
  }

  static DemoLocalizations? of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message('Flutter App',
        name: 'title', desc: 'Title for Demo application');
  }

  String remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return DemoLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations> old) =>
      false;
}
