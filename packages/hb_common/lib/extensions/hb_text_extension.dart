import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/hb_style.dart';

extension HbTextExtension on String {
  Text toText(
    double fontSize, {
    TextAlign? textAlign,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Text text11({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11);
  }

  Text text11w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11w500);
  }

  Text text11w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11w600);
  }

  Text text11Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11Bold);
  }

  Text text11Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11Grey);
  }

  Text text11w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11w500Grey);
  }

  Text text11w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11w600Grey);
  }

  Text text11BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text11BoldGrey);
  }

  Text text12({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12);
  }

  Text text12w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12w500);
  }

  Text text12w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12w600);
  }

  Text text12Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12Bold);
  }

  Text text12Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12Grey);
  }

  Text text12w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12w500Grey);
  }

  Text text12w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12w600Grey);
  }

  Text text12BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text12BoldGrey);
  }

  Text text13({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13);
  }

  Text text13w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13w500);
  }

  Text text13w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13w600);
  }

  Text text13Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13Bold);
  }

  Text text13Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13Grey);
  }

  Text text13w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13w500Grey);
  }

  Text text13w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13w600Grey);
  }

  Text text13BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text13BoldGrey);
  }

  Text text14({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14);
  }

  Text text14w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14w500);
  }

  Text text14w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14w600);
  }

  Text text14Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14Bold);
  }

  Text text14Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14Grey);
  }

  Text text14w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14w500Grey);
  }

  Text text14w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14w600Grey);
  }

  Text text14BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text14BoldGrey);
  }

  Text text15({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15);
  }

  Text text15w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15w500);
  }

  Text text15w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15w600);
  }

  Text text15Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15Bold);
  }

  Text text15Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15Grey);
  }

  Text text15w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15w500Grey);
  }

  Text text15w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15w600Grey);
  }

  Text text15BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text15BoldGrey);
  }

  Text text16({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16);
  }

  Text text16w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16w500);
  }

  Text text16w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16w600);
  }

  Text text16Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16Bold);
  }

  Text text16Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16Grey);
  }

  Text text16w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16w500Grey);
  }

  Text text16w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16w600Grey);
  }

  Text text16BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text16BoldGrey);
  }

  Text text24({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24);
  }

  Text text24w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24w500);
  }

  Text text24w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24w600);
  }

  Text text24Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24Bold);
  }

  Text text24Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24Grey);
  }

  Text text24w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24w500Grey);
  }

  Text text24w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24w600Grey);
  }

  Text text24BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text24BoldGrey);
  }

  Text text28({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28);
  }

  Text text28w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28w500);
  }

  Text text28w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28w600);
  }

  Text text28Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28Bold);
  }

  Text text28Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28Grey);
  }

  Text text28w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28w500Grey);
  }

  Text text28w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28w600Grey);
  }

  Text text28BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text28BoldGrey);
  }

  Text text32({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32);
  }

  Text text32w500({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32w500);
  }

  Text text32w600({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32w600);
  }

  Text text32Bold({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32Bold);
  }

  Text text32Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32Grey);
  }

  Text text32w500Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32w500Grey);
  }

  Text text32w600Grey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32w600Grey);
  }

  Text text32BoldGrey({TextAlign? textAlign}) {
    return Text(this, textAlign: textAlign, style: HbStyle.text32BoldGrey);
  }
}
