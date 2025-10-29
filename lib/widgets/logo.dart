

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
