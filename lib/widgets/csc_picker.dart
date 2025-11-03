import 'package:agent_porta/widgets/Text_field.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Widget buildCscField({
  required String label,
  IconData? icon,
  required TextEditingController countryController,
  required TextEditingController stateController,
  required TextEditingController cityController,
  required Function(String?) onCountryChanged,
  required Function(String?) onStateChanged,
  required Function(String?) onCityChanged,
}) {
  return Column(
    children: [
      buildFieldLabel(label: label, icon: icon ?? PhosphorIconsFill.mapTrifold),
      SizedBox(height: 8.h),
      SelectState(
        style: TextStyle(),
        onCountryChanged: (value) {
          onCountryChanged(value);
        },
        onStateChanged: (value) {
          onStateChanged(value);
        },
        onCityChanged: (value) {
          onCityChanged(value);
        },
      ),
    ],
  );
}
