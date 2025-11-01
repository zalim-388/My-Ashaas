import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? hintText;
  final FocusNode? focusNode;
  final bool obscureText;
  final Function()? onTap;
  final bool isSelected;
  final bool showBorder;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? activeTitleColor;
  final Color? inactiveTitleColor;
  final Color? tileColor;
  final BorderRadius? borderRadius;
  final IconData? icon;
  final VoidCallback? onPressedIcon;
  final TextInputType keyboardType;
  final Color? cursorColor;
  final Widget? subtitle;
  final Widget? titlewidget;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;

  const CustomListTile({
    Key? key,
    this.title,
    this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.onTap,
    this.isSelected = false,
    this.showBorder = false,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeTitleColor,
    this.inactiveTitleColor,
    this.tileColor,
    this.borderRadius,
    this.icon,
    this.onPressedIcon,
    this.keyboardType = TextInputType.text,
    this.cursorColor = Colors.grey,
    this.subtitle,
    this.titlewidget,
    this.contentPadding,
    this.validator,
    this.controller,

    this.prefix,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
         style: GTextStyle.label.copyWith(color: kPrimaryColor)

          // color:
          // kPrimaryColor,
          // fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 8.h),
        Container(
          height: 40.h,
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            inputFormatters: inputFormatters,
            style: GTextStyle.bodyLight,
            keyboardType: keyboardType,
            obscureText: obscureText,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              prefix: prefix,
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: hintText,
              hintStyle: GTextStyle.bodyBold.copyWith(
                color: Colors.black45,
                fontSize: 15.sp,
                fontFamily: 'qs',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.w),
              ),
              errorStyle: GTextStyle.bodyBold.copyWith(
                color: kErrorcolor.withOpacity(0.7),
                fontSize: 14.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              isDense: true,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}


        // icon != null
        //           ? IconButton(
        //             style: ButtonStyle(
        //               minimumSize: MaterialStateProperty.all(
        //                 const Size.square(1),
        //               ),
        //             ),
        //             onPressed: onPressedIcon,
        //             icon: Icon(
        //               icon,
        //               size: 20,
        //               color:
        //                   isSelected
        //                       ? activeIconColor ?? Colors.black87
        //                       : inactiveIconColor ?? kPrimaryColor,
        //             ),
        //           )
        //           : null,
        //   contentPadding:
        //       contentPadding ?? const EdgeInsets.fromLTRB(20, 5, 5, 5),
        //   dense: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: borderRadius ?? BorderRadius.circular(10),
        //     side: BorderSide(
        //       color: activeIconColor ?? kPrimaryColor,
        //       width: 1.w,
        //     ),
        //   ),
        //   tileColor:
        //       isSelected
        //           ? tileColor ?? Colors.grey.withOpacity(.01)
        //           : Colors.grey.shade50,





