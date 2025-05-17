// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'intl/messages.dart';
import 'intl/messages_en.dart';

/// The actual `Localizations` class is [HbQrLocalizationsImpl],
/// this class exists only for forward compatibility purposes...
class HbQrLocalizations {
  HbQrLocalizations._();

  /// The [HbQrLocalizationsImpl] instance for the current context.
  static HbQrLocalizationsImpl of(BuildContext context) {
    return Localizations.of<HbQrLocalizationsImpl>(
          context,
          HbQrLocalizationsImpl,
        ) ??
        _default;
  }

  /// The [HbQrLocalizationsImpl] instance delegate.
  static const LocalizationsDelegate<HbQrLocalizationsImpl> delegate =
      HbQrLocalizationsDelegate();

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
      HbQrLocalizationsImpl.supportedLocales;

  static final HbQrLocalizationsImplEn _default = HbQrLocalizationsImplEn();

  static HbQrLocalizationsImpl? _current;

  /// Set the current [HbQrLocalizationsImpl] instance.
  static void setCurrentInstance(HbQrLocalizationsImpl? current) =>
      _current = current;

  /// The current [HbQrLocalizationsImpl] instance.
  static HbQrLocalizationsImpl get current => _current ?? _default;
}

/// The actual `Localizations` class is [HbQrLocalizationsImpl],
class HbQrLocalizationsDelegate
    extends LocalizationsDelegate<HbQrLocalizationsImpl> {
  /// Constructor for the delegate class.
  const HbQrLocalizationsDelegate();

  @override
  Future<HbQrLocalizationsImpl> load(Locale locale) {
    final HbQrLocalizationsImpl instance = lookupHbQrLocalizationsImpl(locale);
    HbQrLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<HbQrLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) => HbQrLocalizationsImpl.supportedLocales
      .map((Locale e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  bool shouldReload(HbQrLocalizationsDelegate old) => false;
}
