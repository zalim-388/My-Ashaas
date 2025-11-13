import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';

Widget buildlogo() {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/images/portalogoBg.png',
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
          colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomCenter,
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
