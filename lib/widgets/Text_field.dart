import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildFieldLabel({
  required String label,
  IconData? icon,
  double? topPad,
}) {
  return Padding(
    padding: EdgeInsets.only(
      bottom: 5.0,
      left: 10,
      right: 5,
      top: topPad ?? 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GTextStyle.label.copyWith(color: kPrimaryColor)),
        Icon(icon, size: 18, color: kPrimaryColor),
      ],
    ),
  );
}

Widget buildADDField({
  required String label,
  required String hintText,
  required TextEditingController Controller,
  String? Function(String?)? validator,
  IconData? icon,
  TextInputType? keybordType,
  double? topPad,
  TextCapitalization textCapitalization = TextCapitalization.none,
  bool readOnly = false,
  VoidCallback? onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad),

      TextFormField(
        cursorErrorColor: kPrimaryColor,
        cursorColor: kPrimaryColor,
        controller: Controller,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          hintText: Controller.text.isEmpty ? hintText : null,
          hintStyle: GTextStyle.bodyBold.copyWith(
            color: Colors.black45,
            fontSize: 15.sp,
            fontFamily: 'qs',
          ),
          errorStyle: GTextStyle.bodyLight.copyWith(
            color: kErrorcolor,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            fontFamily: 'qs',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),

          filled: true,
          fillColor: Colors.grey.shade100,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly,
        onTap: onTap,
        style: GTextStyle.bodyBold.copyWith(
          color: kPrimaryColor,
          fontSize: 15.sp,
        ),
        validator: validator,
        keyboardType: keybordType,
      ),
    ],
  );
}
