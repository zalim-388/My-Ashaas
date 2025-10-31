import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDropdown({
  required String label,
  IconData? icon,
  double? topPad,
  required Function(String?) onChanged,
  required BuildContext context,
  String? selectedValue,
  required List<String> options,
  String? hintText,
  bool isSearchable = false,
  bool enabled = true,
  String Function(String?)? validator,
}) {
  final String? validValue =
      (selectedValue != null && options.contains(selectedValue))
          ? selectedValue
          : null;

  return Column(
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad),

      SizedBox(height: 8.h),

      DropdownSearch<String>(
        items: (filter, ScrollProps) => options,
        selectedItem: validValue,
        onChanged: enabled ? onChanged : null,
        enabled: enabled,

        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: kPrimaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: selectedValue ?? hintText!,
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
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: isSearchable,

          searchFieldProps: TextFieldProps(
            cursorErrorColor: kPrimaryColor,
            cursorColor: kPrimaryColor,

            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: GTextStyle.bodyBold.copyWith(
                color: Colors.black45,
                fontSize: 15.sp,
                fontFamily: 'qs',
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),

            style: GTextStyle.bodyBold.copyWith(
              color: kPrimaryColor,
              fontSize: 15.sp,
            ),
          ),
          itemBuilder: (context, item, isDisabled, isSelected) {
            return Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.grey.shade100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item,
                      style: GTextStyle.bodyBold.copyWith(
                        color: kPrimaryColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          searchDelay: Duration(milliseconds: 200),
        ),
        validator: validator,
      ),
    ],
  );
}
