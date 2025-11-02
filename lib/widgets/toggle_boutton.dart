import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildToggle({
  required String label,
  IconData? icon,
  double? topPad,
  required bool? selection,
  required ValueChanged<bool?> onChanged,
  required String title,
  required String title1,
  IconData? icon1,
  IconData? icon2,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFieldLabel(label: label, icon: icon, topPad: topPad),

      SegmentedButton<bool>(
      
        emptySelectionAllowed: true,
        showSelectedIcon: false,
        segments: <ButtonSegment<bool>>[
          ButtonSegment(
            value: true,
            icon: icon1 != null ? Icon(icon1) : null,
            label: Text(title),
          ),
          ButtonSegment(
            value: false,
            icon: icon2 != null ? Icon(icon2) : null,
            label: Text(title1),
          ),
        ],

        selected: <bool>{if (selection != null) selection},
        onSelectionChanged: (Set<bool> newSelection) {
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

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    ],
  );
}







// import 'package:agent_porta/styles/constants.dart';
// import 'package:agent_porta/widgets/Text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';



// Widget buildToggle({
//   required String label,
//   IconData? icon,
//   required bool? selection,
//   required ValueChanged<bool?> onChanged,
//   double? topPad,
//   required String title,
//   required String title1,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       buildFieldLabel(label: label, icon: icon, topPad: topPad),

//       ToggleButtons(
//         isSelected: [selection == true, selection == false],

//         onPressed: (int index) {
//           bool newvalue = (index == 0);
//           if (newvalue == selection) {
//             onChanged(null);
//           } else {
//             onChanged(newvalue);
//           }
//         },

//         borderRadius: BorderRadius.circular(8.r),
//         selectedColor: Colors.white,
//         fillColor: kPrimaryColor,

//         constraints: BoxConstraints(minHeight: 45.h, minWidth: double.infinity),
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Text(title),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Text(title1),
//           ),
//         ],
//       ),
//     ],
//   );
// }
