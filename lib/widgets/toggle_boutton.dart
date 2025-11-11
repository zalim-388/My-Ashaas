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
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(
        label: label,
        icon: icon,
        topPad: topPad,
        context: context,
      ),

      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Row(
            children:
                options.map((option) {
                  final bool isSelected = selection == option.label;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(option.label);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? kPrimaryColor : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (option.icon != null) ...[
                              Icon(
                                option.icon,
                                size: 16,
                                color:
                                    isSelected ? Colors.white : kPrimaryColor,
                              ),
                              SizedBox(width: 4.w),
                            ],
                            Flexible(
                              child: Text(
                                option.label,
                                textAlign: TextAlign.center,
                                style: GTextStyle.bodyBold.copyWith(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : kPrimaryColor.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
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
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      buildFieldLabel(
        label: label,
        icon: icon,
        topPad: topPad,
        context: context,
      ),
      SizedBox(height: 6.h),
      GridView.builder(
        itemCount: options.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.4,
          crossAxisSpacing: 8.0.w,
          mainAxisSpacing: 8.0.h,
        ),
        itemBuilder: (context, index) {
          final option = options[index];

          final bool isSelected =
              selection?.any(
                (selectedOption) => selectedOption == option.label,
              ) ??
              false;

          return FilterChip(
            showCheckmark: false,
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (option.icon != null) ...[
                    Icon(
                      option.icon,
                      size: 16,
                      color: isSelected ? Colors.white : kPrimaryColor,
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Text(
                    option.label,
                    style: GTextStyle.bodyBold.copyWith(
                      color:
                          isSelected
                              ? Colors.white
                              : kPrimaryColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            selected: isSelected,

            backgroundColor: Colors.grey.shade100,
            selectedColor: kPrimaryColor,
            checkmarkColor: Colors.white,
            side: BorderSide.none,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),

            labelPadding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 6.0.w : 8.0.w,
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
        },
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
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(
        label: label,
        icon: icon,
        topPad: topPad,
        context: context,
      ),
      SizedBox(height: 6.h),

      Row(
        children:
            options.map((option) {
              final bool isSelected = selection == option.label;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                  child: FilterChip(
                    showCheckmark: false,
                    label: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 5.h,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (option.icon != null) ...[
                              Icon(
                                option.icon,
                                size: 16,
                                color:
                                    isSelected ? Colors.white : kPrimaryColor,
                              ),
                              SizedBox(width: 4.w),
                            ],
                            Text(
                              option.label,
                              style: GTextStyle.bodyBold.copyWith(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : kPrimaryColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    selected: isSelected,
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: kPrimaryColor,
                    checkmarkColor: Colors.white,
                    side: BorderSide.none,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    labelPadding: EdgeInsets.zero,
                    onSelected: (bool value) {
                      if (value) {
                        onChanged(option.label);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
      ),
    ],
  );
}
