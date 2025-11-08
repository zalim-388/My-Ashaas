import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildFieldLabel({
  required String label,
  IconData? icon,
  double? topPad,
  double? fontSize,
  required BuildContext context,
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Padding(
    padding: EdgeInsets.only(
      bottom: 5.0.h,
      left: 10.w,
      right: 5.w,
      top: topPad ?? 20.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,

            style: GTextStyle.label.copyWith(
              color: kPrimaryColor,
              fontSize: isLandscape ? 8.sp : fontSize ?? 15.sp,
            ),
          ),
        ),
        Icon(icon, size: isLandscape ? 10.sp : 18.sp, color: kPrimaryColor),
      ],
    ),
  );
}

Widget buildADDField({
  String? label,
  String? helperText,
  required String hintText,
  required TextEditingController Controller,
  String? Function(String?)? validator,
  IconData? icon,
  TextInputType? keybordType,
  double? topPad,
  TextCapitalization textCapitalization = TextCapitalization.none,
  bool readOnly = false,
  VoidCallback? onTap,
  Function(String)? onChanged,
  double? fontSize,
  int? maxlength,
  int? maxlines,
  int? minlines,
  bool showBorderside = false,
  required BuildContext context,
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  final borderside =
      showBorderside
          ? BorderSide(color: kPrimaryColor, width: isLandscape ? 0.5.w : 1.w)
          : BorderSide.none;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(
        context: context,
        label: label ?? "",
        icon: icon,
        topPad: topPad,
        fontSize: fontSize,
      ),

      TextFormField(
        onChanged: onChanged,
        cursorErrorColor: kPrimaryColor,
        cursorColor: kPrimaryColor,
        controller: Controller,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          helperText: helperText,
          helperStyle: GTextStyle.bodyLight.copyWith(
            color: kPrimaryColor,
            fontSize: isLandscape ? 8.sp : fontSize ?? 14.sp,
          ),

          hintText: Controller.text.isEmpty ? hintText : null,
          hintStyle: GTextStyle.bodyLight.copyWith(
            color: Colors.black45,
            fontSize: isLandscape ? 8.sp : fontSize ?? 14.sp,
          ),
          errorStyle: GTextStyle.bodyLight.copyWith(
            color: kErrorcolor,
            fontWeight: FontWeight.w300,
            fontSize: isLandscape ? 7.sp : 13.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderside,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderside,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderside,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: borderside,
          ),

          filled: true,
          fillColor: Colors.grey.shade100,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 8.w : 12.w,
            vertical: 10.h,
          ),
        ),
        maxLength: maxlength,
        maxLines: maxlines,
        minLines: minlines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly,
        onTap: onTap,
        style: GTextStyle.bodyBold.copyWith(
          color: kPrimaryColor,
          fontSize: isLandscape ? 8.sp : 15.sp,
        ),
        validator: validator,
        keyboardType: keybordType,
      ),
    ],
  );
}
