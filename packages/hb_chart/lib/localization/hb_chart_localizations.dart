// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'intl/messages.dart';
import 'intl/messages_en.dart';

/// The actual `Localizations` class is [HbChartLocalizationsImpl],
/// this class exists only for forward compatibility purposes...
class HbChartLocalizations {
  HbChartLocalizations._();

  /// The [HbChartLocalizationsImpl] instance for the current context.
  static HbChartLocalizationsImpl of(BuildContext context) {
    return Localizations.of<HbChartLocalizationsImpl>(
          context,
          HbChartLocalizationsImpl,
        ) ??
        _default;
  }

  /// The [HbChartLocalizationsImpl] instance delegate.
  static const LocalizationsDelegate<HbChartLocalizationsImpl> delegate =
      HbChartLocalizationsDelegate();

  /// The [GlobalMaterialLocalizations.delegate],
  /// [GlobalCupertinoLocalizations.delegate], and
  /// [GlobalWidgetsLocalizations.delegate] delegates.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// The supported locales.
  static const List<Locale> supportedLocales =
      HbChartLocalizationsImpl.supportedLocales;

  static final HbChartLocalizationsImplEn _default =
      HbChartLocalizationsImplEn();

  static HbChartLocalizationsImpl? _current;

  /// Set the current [HbChartLocalizationsImpl] instance.
  static void setCurrentInstance(HbChartLocalizationsImpl? current) =>
      _current = current;

  /// The current [HbChartLocalizationsImpl] instance.
  static HbChartLocalizationsImpl get current => _current ?? _default;
}

/// The actual `Localizations` class is [HbChartLocalizationsImpl],
class HbChartLocalizationsDelegate
    extends LocalizationsDelegate<HbChartLocalizationsImpl> {
  /// Constructor for the delegate class.
  const HbChartLocalizationsDelegate();

  @override
  Future<HbChartLocalizationsImpl> load(Locale locale) {
    final HbChartLocalizationsImpl instance =
        lookupHbChartLocalizationsImpl(locale);
    HbChartLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<HbChartLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) => HbChartLocalizationsImpl.supportedLocales
      .map((Locale e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  bool shouldReload(HbChartLocalizationsDelegate old) => false;
}
