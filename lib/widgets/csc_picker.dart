import 'package:agent_porta/widgets/dropdown.dart'; // Your custom dropdown
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:agent_porta/styles/style.dart'; // You may need your styles
import 'package:agent_porta/widgets/Text_field.dart'; // For buildFieldLabel

Widget buildCscField({
  required BuildContext context,
  required String label,
  required Function(String?) onCountryChanged,
  required Function(String?) onStateChanged,
  required Function(String?) onCityChanged,
  required TextEditingController countryController,
  required TextEditingController stateController,
  required TextEditingController cityController,

  // You need to pass the actual lists of data
  required List<String> countries,
  required List<String> states,
  required List<String> cities,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Use your buildFieldLabel widget
      buildFieldLabel(label: label,
       context: context,
      ),

      // --- 1. COUNTRY DROPDOWN ---
      buildDropdown(
        context: context,
        label: "Country *",
        hintText: "Search your country",
        icon: PhosphorIconsFill.mapTrifold,
        options: countries, // Pass the list of countries
        selectedValue: countryController.text.isEmpty ? null : countryController.text,
        isSearchable: true, // <-- ENABLES SEARCH
        onChanged: onCountryChanged, // Pass your original function
        validator: (value) =>
            (value == null || value.isEmpty) ? "Please select a country" : null,
      ),
      SizedBox(height: 16.h),

      // --- 2. STATE DROPDOWN ---
      // Only show/enable if a country is selected
      if (countryController.text.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: buildDropdown(
            context: context,
            label: "State *",
            hintText: "Search your state",
            icon: PhosphorIconsFill.mapTrifold,
            options: states, // Pass the list of states
            selectedValue: stateController.text.isEmpty ? null : stateController.text,
            isSearchable: true, // <-- ENABLES SEARCH
            onChanged: onStateChanged, // Pass your original function
            validator: (value) =>
                (value == null || value.isEmpty) ? "Please select a state" : null,
          ),
        ),

      // --- 3. CITY DROPDOWN ---
      // Only show/enable if a state is selected
      if (stateController.text.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: buildDropdown(
            context: context,
            label: "City *",
            hintText: "Search your city",
            icon: PhosphorIconsFill.mapTrifold,
            options: cities, // Pass the list of cities
            selectedValue: cityController.text.isEmpty ? null : cityController.text,
            isSearchable: true, // <-- ENABLES SEARCH
            onChanged: onCityChanged, // Pass your original function
            validator: (value) =>
                (value == null || value.isEmpty) ? "Please select a city" : null,
          ),
        ),
    ],
  );
}