import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

Widget buildAppbar({
  VoidCallback? onPressedLeading,
  IconData? leadingIcon,
  Color? leadingColor,
  Color? appbarColor,
  String? titleText,
  Widget? titleWidget,
  Color? titleColor,
  List<Widget>? action,
  double? elevation,
  bool centerTitle = false,
  PreferredSizeWidget? bottom,
  EdgeInsets? actionPadding,
  double? leadingWidth,
  double? leadingButtonhorizontal,
  bool automaticallyImplyLeading = false,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    backgroundColor: appbarColor ?? kBackgroundColor,
    leading:
        onPressedLeading != null
            ? IconButton(
              highlightColor: kprimaryGreen.withOpacity(0.1),
              onPressed: onPressedLeading,
              icon: Icon(
                leadingIcon ?? PhosphorIconsBold.caretLeft,
                color: leadingColor ?? kIconColor,
                size: 20.spMin,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: leadingButtonhorizontal ?? 8.w,
              ),
            )
            : null,

    centerTitle: centerTitle,
    elevation: elevation ?? 0,
    scrolledUnderElevation: 0,
    leadingWidth: leadingWidth,
    title:
        titleWidget ??
        (titleText != null
            ? Text(
              titleText,
              style: GTextStyle.heading2Bold.copyWith(
                color: titleColor ?? black,
                // fontFamily: 'Serif',
              ),
            )
            : null),
    actionsPadding: actionPadding ?? EdgeInsets.symmetric(horizontal: 8.w),

    actions: action ?? [],
    bottom: bottom,
  );
}
