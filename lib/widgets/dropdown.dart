import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

Widget buildDropdown({
  required String label,
  IconData? icon,
  double? topPad,
  required Function(String?) onChanged,
  required BuildContext context,
  String? selectedValue,
  List<String>? options,
  String? hintText,
  bool isSearchable = false,
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  InputDecoration getInputDecoration(String? hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 8.w : 12.w,
        vertical: 10.h,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      fillColor: Colors.grey.shade100,
      filled: true,

      hintText: selectedValue ?? hintText,
      hintStyle: GTextStyle.bodyLight.copyWith(
        color: Colors.black45,
        fontSize: isLandscape ? 8.sp : 14.sp,
      ),

      errorStyle: GTextStyle.bodyLight.copyWith(
        color: kErrorcolor,
        fontWeight: FontWeight.w300,
        fontSize: isLandscape ? 7.sp : 13.sp,
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
      isDense: true,
    );
  }

  return Column(
    children: [
      buildFieldLabel(
        label: label,
        icon: icon,
        topPad: topPad,
        context: context,
      ),

      SizedBox(height: 8.h),
      if (isSearchable)
        Autocomplete(
          fieldViewBuilder: (
            BuildContext context,

            TextEditingController fieldController,
            FocusNode fieldfocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: controller ?? fieldController,
              focusNode: fieldfocusNode,

              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 8.sp : 14.sp,
                color: kPrimaryColor,
              ),

              keyboardType: keyboardType,
              cursorColor: kPrimaryColor,
              decoration: getInputDecoration(hintText),
              validator: validator,
            );
          },

          optionsBuilder: (TextEditingValue textEditingValue) {
            if (options == null) {
              return const Iterable<String>.empty();
            }
            if (textEditingValue.text.isEmpty) {
              return options;
            }
            return options.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.r),

                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 250.h),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          child: Text(
                            option,
                            style: GTextStyle.bodyBold.copyWith(
                              color: kPrimaryColor,
                              fontSize: isLandscape ? 8.sp : 15.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          onSelected: (String option) {
            onChanged(option);
          },
        )
      else
        DropdownSearch<String>(
          items: (filter, loadProps) => options ?? [],
          selectedItem:
              (selectedValue != null && (options ?? []).contains(selectedValue))
                  ? selectedValue
                  : null,

          onChanged: onChanged,
          decoratorProps: DropDownDecoratorProps(
            decoration: getInputDecoration(selectedValue ?? hintText),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Text(
                  item,
                  style: GTextStyle.bodyBold.copyWith(
                    color: kPrimaryColor,
                    fontSize: isLandscape ? 8.sp : 14.sp,
                  ),
                ),
              );
            },
          ),
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconClosed: Icon(Icons.keyboard_arrow_down, color: kPrimaryColor),
              iconOpened: Icon(Icons.keyboard_arrow_up, color: kPrimaryColor),
            ),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
    ],
  );
}
