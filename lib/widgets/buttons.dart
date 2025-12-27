import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';

Widget buildButtions({
  required BuildContext context,
  String? label,
  Color? gradientColor1,
  Color? gradientColor2,
  Color? textColor,
  VoidCallback? onTap,
  BorderRadius? radius,
  double? height,
  double? width,
  bool showborder = false,
  Color? borderColor,
  Color? solidColor,
  bool usesolidColor = false,
  IconData? icon,
  Color? iconColor,
  double? fontSize,
  Widget? child,
}) {
  final boderSide =
      showborder
          ? Border.all(color: borderColor ?? kPrimaryColor, width: 1.w)
          : null;

  return InkWell(
    onTap:
        onTap != null
            ? () {
              onTap();
            }
            : null,

    borderRadius: radius ?? BorderRadius.circular(30.r),
    child: Container(
      height: height ?? 40.h,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: boderSide,
        color: usesolidColor ? (solidColor ?? kPrimaryColor) : null,

        gradient:
            !usesolidColor
                ? LinearGradient(
                  colors: [
                    gradientColor1 ?? kBottomNavBarSelected.withOpacity(0.65),
                    gradientColor2 ?? kBottomNavBarSelected,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomCenter,
                )
                : null,
        borderRadius: radius ?? BorderRadius.circular(30.r),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (child != null) ...[SizedBox(width: 8.w)],

          if (icon != null) ...[
            Icon(icon, color: iconColor ?? Colors.white),
            SizedBox(width: 8.w),
          ],
          Text(
            label ?? "Continue",
            style: GTextStyle.button.copyWith(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 16.spMin,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
// LinearGradient(
//                   colors: [
//                     gradientColor1 ?? kBottomNavBarSelected,
//                     gradientColor2 ?? kprimaryGreen,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   stops: [0.0, 0.9],
//                   tileMode: TileMode.decal,
//                 )
//                 : null,