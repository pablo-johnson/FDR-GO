import 'dart:async';

import 'package:flutter/material.dart';

import 'fdr_localizations.dart';

class FdrLocalizationsDelegate extends LocalizationsDelegate<FdrLocalizations> {
  const FdrLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<FdrLocalizations> load(Locale locale) => FdrLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<FdrLocalizations> old) => false;
}
