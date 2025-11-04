import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'messages_en.dart';
import 'messages_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of HbChartLocalizationsImpl
/// returned by `HbChartLocalizationsImpl.of(context)`.
///
/// Applications need to include `HbChartLocalizationsImpl.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/messages.dart';
///
/// return MaterialApp(
///   localizationsDelegates: HbChartLocalizationsImpl.localizationsDelegates,
///   supportedLocales: HbChartLocalizationsImpl.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the HbChartLocalizationsImpl.supportedLocales
/// property.
abstract class HbChartLocalizationsImpl {
  HbChartLocalizationsImpl(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static HbChartLocalizationsImpl of(BuildContext context) {
    return Localizations.of<HbChartLocalizationsImpl>(
        context, HbChartLocalizationsImpl)!;
  }

  static const LocalizationsDelegate<HbChartLocalizationsImpl> delegate =
      _HbChartLocalizationsImplDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @dayFormat.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String dayFormat(DateTime date);

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @changeAmount.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeAmount;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change%'**
  String get change;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;
}

class _HbChartLocalizationsImplDelegate
    extends LocalizationsDelegate<HbChartLocalizationsImpl> {
  const _HbChartLocalizationsImplDelegate();

  @override
  Future<HbChartLocalizationsImpl> load(Locale locale) {
    return SynchronousFuture<HbChartLocalizationsImpl>(
        lookupHbChartLocalizationsImpl(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_HbChartLocalizationsImplDelegate old) => false;
}

HbChartLocalizationsImpl lookupHbChartLocalizationsImpl(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return HbChartLocalizationsImplEn();
    case 'zh':
      return HbChartLocalizationsImplZh();
  }

  throw FlutterError(
      'HbChartLocalizationsImpl.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
