
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';

Widget buildFieldLabel({
  required String label,
  IconData? icon,
  double? topPad,
  double? fontSize,
  required BuildContext context,
}) {
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
              color: kTextPrimary,
              fontSize: fontSize ?? 17.spMin,
            ),
          ),
        ),
        Icon(icon, size: 20.spMin, color: kIconColor),
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
  String? perfixText,
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  final borderside =
      showBorderside
          ? BorderSide(
            color: kTextFieldBorder,
            width: isLandscape ? 0.5.w : 1.w,
          )
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
        cursorErrorColor: kTextFieldBorder,
        cursorColor: kTextFieldBorder,
        controller: Controller,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          prefixText: perfixText,
          prefixStyle: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
          helperText: helperText,
          helperStyle: GTextStyle.bodyLight.copyWith(color: kTextPrimary),

          hintText: Controller.text.isEmpty ? hintText : null,
          hintStyle: GTextStyle.bodyLight.copyWith(color: Colors.black45),
          errorStyle: GTextStyle.bodyLight.copyWith(
            color: kErrorcolor,
            fontWeight: FontWeight.w300,
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
          fillColor: kBackgroundColor,
          // Color(0xFFFFFEF5),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 8.w : 12.w,
            vertical: 12.h,
          ),
        ),
        maxLength: maxlength,
        maxLines: maxlines,
        minLines: minlines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly,
        onTap: onTap,
        style: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
        validator: validator,
        keyboardType: keybordType,
      ),
    ],
  );
}
