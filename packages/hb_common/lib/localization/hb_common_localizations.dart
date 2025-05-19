// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'intl/messages.dart';
import 'intl/messages_en.dart';

/// The actual `Localizations` class is [HbCommonLocalizationsImpl],
/// this class exists only for forward compatibility purposes...
class HbCommonLocalizations {
  HbCommonLocalizations._();

  /// The [HbCommonLocalizationsImpl] instance for the current context.
  static HbCommonLocalizationsImpl of(BuildContext context) {
    return Localizations.of<HbCommonLocalizationsImpl>(
          context,
          HbCommonLocalizationsImpl,
        ) ??
        _default;
  }

  /// The [HbCommonLocalizationsImpl] instance delegate.
  static const LocalizationsDelegate<HbCommonLocalizationsImpl> delegate =
      HbCommonLocalizationsDelegate();

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
      HbCommonLocalizationsImpl.supportedLocales;

  static final HbCommonLocalizationsImplEn _default =
      HbCommonLocalizationsImplEn();

  static HbCommonLocalizationsImpl? _current;

  /// Set the current [HbCommonLocalizationsImpl] instance.
  static void setCurrentInstance(HbCommonLocalizationsImpl? current) =>
      _current = current;

  /// The current [HbCommonLocalizationsImpl] instance.
  static HbCommonLocalizationsImpl get current => _current ?? _default;
}

/// The actual `Localizations` class is [HbCommonLocalizationsImpl],
class HbCommonLocalizationsDelegate
    extends LocalizationsDelegate<HbCommonLocalizationsImpl> {
  /// Constructor for the delegate class.
  const HbCommonLocalizationsDelegate();

  @override
  Future<HbCommonLocalizationsImpl> load(Locale locale) {
    final HbCommonLocalizationsImpl instance = lookupHbCommonLocalizationsImpl(
      locale,
    );
    HbCommonLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<HbCommonLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) => HbCommonLocalizationsImpl.supportedLocales
      .map((Locale e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  bool shouldReload(HbCommonLocalizationsDelegate old) => false;
}
