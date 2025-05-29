import 'package:hb_router/hb_router.dart';
import 'package:intl/intl.dart';

import '../utils/hb_util.dart';

extension HbDateFormatExtension on DateTime? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMMMMd,
    );
  }

  String get dateFormat {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String dateToFormat({DateFormat Function([dynamic])? format}) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: format,
    );
  }
}

extension HbDateIntFormatExtension on num? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMMMMd,
    );
  }

  String get dateFormat {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String dateToFormat({DateFormat Function([dynamic])? format}) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: format,
    );
  }
}

extension HbDateStringFormatExtension on String? {
  String get yMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMd,
    );
  }

  String get yMMMMd {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: DateFormat.yMMMMd,
    );
  }

  String get dateFormat {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
    );
  }

  String dateToFormat({DateFormat Function([dynamic])? format}) {
    return HbUtil.dateTimeFormat(
      HbRouter.key.currentState!.context,
      time: this,
      format: format,
    );
  }
}
