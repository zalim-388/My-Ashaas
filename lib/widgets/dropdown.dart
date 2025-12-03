import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  double? fontSize,
  bool showBorderside = false,
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

  InputDecoration getInputDecoration(String? hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 8.w : 12.w,
        vertical: 11.h,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      fillColor: kBackgroundColor,
      filled: true,

      hintText: selectedValue ?? hintText,
      hintStyle: GTextStyle.bodyLight.copyWith(
        color: Colors.black45,
        // fontSize: isLandscape ? 8.sp : fontSize ?? 14.sp,
      ),

      errorStyle: GTextStyle.bodyLight.copyWith(
        color: kErrorcolor,
        // fontWeight: FontWeight.w300,
        // fontSize: isLandscape ? 7.sp : 13.sp,
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
        fontSize: fontSize,
      ),

      SizedBox(height: 8.h),
      if (isSearchable)
        Autocomplete<String>(
          initialValue: TextEditingValue(text: selectedValue ?? ""),
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldController,
            FocusNode fieldfocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: fieldController,
              focusNode: fieldfocusNode,
              style: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
              keyboardType: keyboardType,
              cursorColor: kTextFieldBorder,
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
              return option.toLowerCase().startsWith(
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
                color: kBackgroundColor,
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
                            style: GTextStyle.bodyMedium.copyWith(
                              color: kTextPrimary,
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
            baseStyle: GTextStyle.bodyMedium.copyWith(color: kTextPrimary),
            decoration: getInputDecoration(selectedValue ?? hintText),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSelectedItems: true,
            disabledItemFn: (String item) => false,
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Text(
                  item,
                  style: GTextStyle.bodyMedium.copyWith(color: kTextPrimary),
                ),
              );
            },
          ),
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconClosed: Icon(
                Icons.keyboard_arrow_down,
                color: kIconColor,
                size: 18.spMin,
              ),
              iconOpened: Icon(
                Icons.keyboard_arrow_up,
                color: kIconColor,
                size: 18.spMin,
              ),
            ),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
    ],
  );
}
