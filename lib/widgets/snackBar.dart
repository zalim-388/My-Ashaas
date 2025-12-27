

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<void> showSnackBar({
  required BuildContext context,
  required String message,
  String type = 'info',
  int seconds = 3,
  bool showClose = true,
  bool showUndo = false,
  VoidCallback? onUndo,
}) async {
  late Color? bgColor;
  late IconData icon;
  switch (type.toLowerCase()) {
    case 'success':
      bgColor = Colors.green.shade500;
      icon = PhosphorIconsLight.checkCircle;
      break;
    case 'error':
      bgColor = Colors.red.shade500;
      icon = PhosphorIconsLight.xCircle;
      break;
    case 'warning':
      bgColor = Colors.orange.shade500;
      icon = PhosphorIconsLight.warningCircle;
      break;
    case 'info':
      bgColor = Colors.blue.shade500;
      icon = PhosphorIconsLight.info;
      break;
  }

  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: white, size: 24.spMin),

        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            message,
            style: GTextStyle.caption.copyWith(color: white),
          ),
        ),
      ],
    ),

    backgroundColor: bgColor,

    dismissDirection: DismissDirection.horizontal,
    duration: Duration(seconds: seconds),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    margin: EdgeInsets.all(16.w),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    showCloseIcon: showClose,
    closeIconColor: white,
    action:
        showUndo && onUndo != null
            ? SnackBarAction(
              label: 'Undo',
              onPressed: () {
                onUndo();
              },
              textColor: white,
            )
            : null,
  );

   ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void buildShortSnackbar(
  BuildContext context,
  Color? bgColor, {
  required String Message,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final textPainter = TextPainter(
    text: TextSpan(
      text: Message,
      style: GTextStyle.caption.copyWith(color: white),
    ),
    maxLines: null,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: screenWidth - 64.w);

  final textWidth = textPainter.size.width;
  final snacbarWidth = (textWidth + 32.w).clamp(100.w, screenWidth - 32.w);
  final horizonalMargin = (screenWidth - snacbarWidth) / 2;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(

      content: Text(
        Message,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: GTextStyle.caption.copyWith(color: white),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: bgColor ?? black.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: 50.h,
        left: horizonalMargin,
        right: horizonalMargin,
      ),
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.r)),
      elevation: 8,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),
  );
}
