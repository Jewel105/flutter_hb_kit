import 'package:hb_router/hb_router.dart';
import 'package:intl/intl.dart';

import '../utils/hb_util.dart';

extension HbDateFormatExtension on DateTime? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMMMMd,
    );
  }

  String get yMdHms {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String get yMdHm {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
      hmsAddFormat: HmsFormat.hm,
    );
  }

  String dateToFormat({
    DateFormat Function([dynamic])? customFormat,
    HmsFormat? hmsAddFormat,
  }) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: customFormat,
      hmsAddFormat: hmsAddFormat,
    );
  }
}

extension HbDateIntFormatExtension on num? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMMMMd,
    );
  }

  String get yMdHms {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String get yMdHm {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
      hmsAddFormat: HmsFormat.hm,
    );
  }

  String dateToFormat({
    DateFormat Function([dynamic])? customFormat,
    HmsFormat? hmsAddFormat,
  }) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: customFormat,
      hmsAddFormat: hmsAddFormat,
    );
  }
}

extension HbDateStringFormatExtension on String? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMMMMd,
    );
  }

  String get yMdHms {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String get yMdHm {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: DateFormat.yMd,
      hmsAddFormat: HmsFormat.hm,
    );
  }

  String dateToFormat({
    DateFormat Function([dynamic])? customFormat,
    HmsFormat? hmsAddFormat,
  }) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      customFormat: customFormat,
      hmsAddFormat: hmsAddFormat,
    );
  }
}
