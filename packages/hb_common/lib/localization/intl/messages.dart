import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'messages_en.dart';
import 'messages_hi.dart';
import 'messages_pt.dart';
import 'messages_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of HbCommonLocalizationsImpl
/// returned by `HbCommonLocalizationsImpl.of(context)`.
///
/// Applications need to include `HbCommonLocalizationsImpl.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/messages.dart';
///
/// return MaterialApp(
///   localizationsDelegates: HbCommonLocalizationsImpl.localizationsDelegates,
///   supportedLocales: HbCommonLocalizationsImpl.supportedLocales,
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
/// be consistent with the languages listed in the HbCommonLocalizationsImpl.supportedLocales
/// property.
abstract class HbCommonLocalizationsImpl {
  HbCommonLocalizationsImpl(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static HbCommonLocalizationsImpl of(BuildContext context) {
    return Localizations.of<HbCommonLocalizationsImpl>(context, HbCommonLocalizationsImpl)!;
  }

  static const LocalizationsDelegate<HbCommonLocalizationsImpl> delegate = _HbCommonLocalizationsImplDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('pt'),
    Locale('zh')
  ];

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @copySuccess.
  ///
  /// In en, this message translates to:
  /// **'Copied successfully'**
  String get copySuccess;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @totalTip.
  ///
  /// In en, this message translates to:
  /// **'No more, a total of {count} records.'**
  String totalTip(int count);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pleaseSelect.
  ///
  /// In en, this message translates to:
  /// **'Please Select'**
  String get pleaseSelect;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @confirmPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password does not match Password'**
  String get confirmPasswordError;
}

class _HbCommonLocalizationsImplDelegate extends LocalizationsDelegate<HbCommonLocalizationsImpl> {
  const _HbCommonLocalizationsImplDelegate();

  @override
  Future<HbCommonLocalizationsImpl> load(Locale locale) {
    return SynchronousFuture<HbCommonLocalizationsImpl>(lookupHbCommonLocalizationsImpl(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'pt', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_HbCommonLocalizationsImplDelegate old) => false;
}

HbCommonLocalizationsImpl lookupHbCommonLocalizationsImpl(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return HbCommonLocalizationsImplEn();
    case 'hi': return HbCommonLocalizationsImplHi();
    case 'pt': return HbCommonLocalizationsImplPt();
    case 'zh': return HbCommonLocalizationsImplZh();
  }

  throw FlutterError(
    'HbCommonLocalizationsImpl.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
