import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Toggleoption {
  final String label;
  final IconData? icon;

  Toggleoption({required this.label, required this.icon});
}

Widget buildToggle({
  required String label,
  IconData? icon,
  double? topPad,
  required List<Toggleoption> options,
  required String? selection,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
  // required String title,
  // required String title1,
  // IconData? icon1,
  // IconData? icon2,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad,
       context: context,
      ),

      SegmentedButton<String>(
        emptySelectionAllowed: true,
        showSelectedIcon: false,
        segments:
            options.map((option) {
              return ButtonSegment<String>(
                value: option.label,
                label: Text(option.label, style: GTextStyle.bodyBold),
                icon: option.icon == null ? null : Icon(option.icon),
              );
            }).toList(),

        selected: <String>{if (selection != null) selection},
        onSelectionChanged: (Set<String> newSelection) {
          if (newSelection.isEmpty) {
            onChanged(null);
          } else {
            onChanged(newSelection.first);
          }
        },
        style: SegmentedButton.styleFrom(
          backgroundColor: Colors.grey.shade100,
          selectedBackgroundColor: kPrimaryColor,
          selectedForegroundColor: Colors.white,
          side: BorderSide.none,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    ],
  );
}

Widget buildToggleMultiChip({
  required String label,
  IconData? icon,
  double? topPad,
  required List<Toggleoption> options,
  required Set<String>? selection,
  required ValueChanged<Set<String>> onChanged,
  required BuildContext context,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad,
       context: context,
      ),
      SizedBox(height: 6.h),
      Wrap(
        spacing: 10.0.w,
        runSpacing: 10.0.h,
        children:
            options.map((option) {
              final bool isSelected =
                  selection?.any(
                    (selectedOption) => selectedOption == option.label,
                  ) ??
                  false;

              return FilterChip(
                showCheckmark: false,
                label: Text(
                  option.label,
                  style: GTextStyle.bodyBold.copyWith(
                    color:
                        isSelected
                            ? Colors.white
                            : kPrimaryColor.withOpacity(0.8),
                  ),
                ),

                avatar:
                    option.icon != null
                        ? Icon(
                          option.icon,
                          color:
                              isSelected
                                  ? Colors.white
                                  : kPrimaryColor.withOpacity(0.8),
                        )
                        : null,
                selected: isSelected,

                backgroundColor: Colors.grey.shade100,
                selectedColor: kPrimaryColor,
                checkmarkColor: Colors.white,
                side: BorderSide.none,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 11.0.w,
                  vertical: 4.0.h,
                ),
                onSelected: (bool? value) {
                  Set<String> newSelection = Set.from(selection ?? <String>{});
                  if (value!) {
                    newSelection.add(option.label);
                  } else {
                    newSelection.remove(option.label);
                  }
                  onChanged(newSelection);
                },
              );
            }).toList(),
      ),
    ],
  );
}

Widget buildToggleSingChip({
  required String label,
  IconData? icon,
  double? topPad,
  required List<Toggleoption> options,
  required String? selection,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad,
       context: context,
      ),
      SizedBox(height: 6.h),

      Wrap(
        spacing: 10.0.w,
        runSpacing: 10.0.h,
        children:
            options.map((option) {
              final bool isSelected = selection == option.label;

              return FilterChip(
                showCheckmark: false,
                label: Text(
                  option.label,
                  style: GTextStyle.bodyBold.copyWith(
                    color:
                        isSelected
                            ? Colors.white
                            : kPrimaryColor.withOpacity(0.8),
                  ),
                ),

                avatar:
                    option.icon != null
                        ? Icon(
                          option.icon,
                          color:
                              isSelected
                                  ? Colors.white
                                  : kPrimaryColor.withOpacity(0.8),
                        )
                        : null,
                selected: isSelected,

                backgroundColor: Colors.grey.shade100,
                selectedColor: kPrimaryColor,
                checkmarkColor: Colors.white,
                side: BorderSide.none,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 14.0.w,
                  vertical: 4.0.h,
                ),
                onSelected: (bool value) {
                  if (value) {
                    onChanged(option.label);
                  }
                },
              );
            }).toList(),
      ),
    ],
  );
}
