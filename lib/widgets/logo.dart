import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';

Widget buildlogo() {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/images/ashaas.png',
      fit: BoxFit.contain,
      height: 180.h,
      width: 180.w,
    ),
  );
}

Widget buildButton({
  required String title,
  required VoidCallback onTap,
  double? height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: height ?? 45.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kBottomNavBarSelected.withOpacity(0.65),
            kBottomNavBarSelected,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.9],
          tileMode: TileMode.decal,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: GTextStyle.button.copyWith(color: Colors.white),
      ),
    ),
  );
}
