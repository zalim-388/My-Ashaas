import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GTextStyle {
  GTextStyle._();

  static  TextStyle get display => TextStyle(
    fontSize: 40.spMin,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static   TextStyle get displayMedium => TextStyle(
    fontSize: 26.0.spMin,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.3.h,
  );

  /// heading  1 style

  static  TextStyle get heading1 => TextStyle(
    fontSize: 24.0.spMin,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.3.h,
  );

  static TextStyle get heading1Medium => TextStyle(
    fontSize: 24.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 1.2.h,
  );

  static TextStyle get heading1Bold => TextStyle(
    fontSize: 25.0.spMin,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  );

  /// heading  2 style

  static TextStyle get heading2 => TextStyle(
    fontSize: 20.0.spMin,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3.h,
  );

  static TextStyle get heading2Medium => TextStyle(
    fontSize: 20.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.3,
    height: 1.2.h,
  );

  static TextStyle get heading2Light => TextStyle(
    fontSize: 20.0.spMin,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.3,
    height: 1.2.h,
  );

  static TextStyle get heading2Bold => TextStyle(
    fontSize: 18.0.spMin,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static TextStyle get heading2Small => TextStyle(
    fontSize: 20.0.spMin,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.3.h,
  );

  /// heading  3 style

  static TextStyle get heading3 => TextStyle(
    fontSize: 18.0.spMin,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4.h,
  );

  static TextStyle get heading3Medium => TextStyle(
    fontSize: 18.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.1,
    height: 1.4.h,
  );

  /// body 1 style (main contant)

  static TextStyle get body => TextStyle(
    fontSize: 16.0.spMin,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5.h,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 16.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.5.h,
  );

  static TextStyle get bodyBold => TextStyle(
    fontSize: 16.0.spMin,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.5.h,
  );

  static TextStyle get bodyLight => TextStyle(
    fontSize: 16.0.spMin,
    fontWeight: FontWeight.w200,
    letterSpacing: 0,
    height: 1.5.h,
  );

  //body secondy contant

  static TextStyle get bodySmall => TextStyle(
    fontSize: 14.0.spMin,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.1,
    height: 1.5.h,
  );

  static TextStyle get bodySmallMedium => TextStyle(
    fontSize: 14.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5.h,
  );
  static TextStyle get bodySmallbold => TextStyle(
    fontSize: 14.0.spMin,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    height: 1.5.h,
  );

  //caption styles (labels...)

  static TextStyle get caption => TextStyle(
    fontSize: 12.0.spMin,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4.h,
  );

  static TextStyle get captionMedium => TextStyle(
    fontSize: 12.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    // height: 1.4.h,
  );

  static TextStyle get captionBold => TextStyle(
    fontSize: 12.0.spMin,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.4.h,
  );

  /// button and label

  static TextStyle get button => TextStyle(
    fontSize: 18.0.spMin,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    height: 1.2.h,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: 14.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.3.h,
  );

  static TextStyle get label => TextStyle(
    fontSize: 14.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.3.h,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 12.0.spMin,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.3.h,
  );
}
