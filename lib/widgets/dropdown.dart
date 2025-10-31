import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/material.dart';
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
}) {
  return Column(
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad),

      SizedBox(height: 8.h),
      GestureDetector(
        onTapDown: (TapDownDetails details) async {
          final selected = await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy,
              MediaQuery.of(context).size.width - details.globalPosition.dx,
              MediaQuery.of(context).size.height - details.globalPosition.dy,
            ),
            items:
                options.map((options) {
                  return PopupMenuItem<String>(
                    value: options,
                    child: Text(options, style: GTextStyle.bodyMedium),
                  );
                }).toList(),
            color: Colors.white,
          );
          if (selected != null) {
            onChanged(selected);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue ?? hintText!,

                style: GTextStyle.bodyBold.copyWith(
                  color: Colors.black45,
                  fontSize: 15.sp,
                  fontFamily: 'qs',
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 16, color: kPrimaryColor),
            ],
          ),
        ),
      ),
    ],
  );
}
