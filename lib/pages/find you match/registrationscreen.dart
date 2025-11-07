import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:agent_porta/widgets/toggle_boutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class registrationscreen extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const registrationscreen({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<registrationscreen> createState() => _registrationscreenState();
}

class _registrationscreenState extends State<registrationscreen> {
  final _fullnameController = TextEditingController();
  final _agetController = TextEditingController();
  final _dobtController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedGender;
  String? _selectedProfile;

  List<String> Profileoptions = [
    "Self",
    "Parent",
    "Sibling",
    'Friend',
    "Relative",
  ];
  List<Toggleoption> genderoptions = [
    Toggleoption(label: "Male", icon: Icons.male),
    Toggleoption(label: "Female", icon:Icons.female ),
    Toggleoption(label: "Others", icon: Icons.help_outline_outlined),
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final DateTime today = DateTime.now();
      int age = today.year - pickedDate.year;
      if (today.month < pickedDate.month ||
          (today.month == pickedDate.month && today.day < pickedDate.day)) {
        age--;
      }
      setState(() {
        _dobtController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        _agetController.text = "$age ";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _agetController.dispose();
    _dobtController.dispose();
    _emailController.dispose();
  }

  void ongenderChanged(newValue) {
    setState(() {
      _selectedGender = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Registration Details",
                style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
              ),
              SizedBox(height: 20.h),

              buildADDField(
                context: context,
                label: 'Full Name *',
                icon: PhosphorIconsFill.userCircle,
                hintText: 'Enter Full Name',
                Controller: _fullnameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
              ),

              buildToggle(
                 context: context,
                label: "Gender",
                options: genderoptions,
                selection: _selectedGender,
                onChanged: ongenderChanged,
              ),
              Row(
                children: [
                  Expanded(
                    child: buildADDField(
                      context: context,
                      label: 'Date of Birth *',
                      icon: PhosphorIconsFill.calendar,
                      hintText: 'Select your Date of Birth',
                      Controller: _dobtController,
                      readOnly: true,
                      onTap: () async {
                        _selectDate(context);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: buildADDField(
                      context: context,
                      label: 'Age *',
                      icon: PhosphorIconsFill.user,
                      hintText: 'your Age',
                      Controller: _agetController,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              buildADDField(
                context: context,
                label: 'Email Id',
                icon: PhosphorIconsFill.envelope,
                hintText: 'Enter Email Id',
                Controller: _emailController,
                keybordType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              buildDropdown(
                label: "Profile Created by *",
                onChanged: (newvalue) {
                  setState(() {
                    _selectedProfile = newvalue;
                  });
                },
                context: context,
                options: Profileoptions.map((e) => e).toList(),
                hintText: "Select Profile Created by",
                selectedValue: _selectedProfile,
                icon: PhosphorIconsFill.userCircle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Profile Created by';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    context: context,
                    onTap: () {
                      if (widget.formkey.currentState?.validate() ?? false) {
                        widget.pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _buildGenderField({
//   required String label,
//   IconData? icon,
//   double? topPad,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       buildFieldLabel(label: label, icon: icon, topPad: topPad),

//       SegmentedButton<Gender>(
//         showSelectedIcon: false,
//         emptySelectionAllowed: true,
//         segments: <ButtonSegment<Gender>>[
//           ButtonSegment(
//             value: Gender.male,
//             icon: Icon(Icons.male),
//             label: Text('Male'),
//           ),
//           ButtonSegment(
//             value: Gender.female,
//             icon: Icon(Icons.female),
//             label: Text('Female'),
//           ),
//           ButtonSegment(
//             value: Gender.other,
//             label: Text('Others'),
//             icon: Icon(Icons.help_outline_outlined),
//           ),
//         ],

//         selected: <Gender>{if (_selectedGender != null) _selectedGender!},
//         onSelectionChanged: (Set<Gender> newSelection) {
//           setState(() {
//             if (newSelection.isNotEmpty) {
//               _selectedGender = newSelection.first;
//             }
//           });
//         },
//         style: SegmentedButton.styleFrom(
//           backgroundColor: Colors.grey.shade100,
//           selectedBackgroundColor: kPrimaryColor,
//           selectedForegroundColor: Colors.white,
//           side: BorderSide.none,

//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//         ),
//       ),
//     ],
//   );
// }



//   Widget buildregistrationscreen(PageController _pageController) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 40.h),

//       child: Form(
//         key: _page1FormKey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,

//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "Registration Details",
//                 style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
//               ),
//               SizedBox(height: 20.h),

//               buildADDField(
//                 label: 'Full Name *',
//                 icon: PhosphorIconsFill.userCircle,
//                 hintText: 'Enter Full Name',
//                 Controller: _fullnameController,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Please enter full name';
//                   }
//                   return null;
//                 },
//               ),

//               _buildGenderField(
//                 label: 'Gender *',
//                 icon: PhosphorIconsFill.genderMale,
//               ),

//               Row(
//                 children: [
//                   Expanded(
//                     child: buildADDField(
//                       label: 'Date of Birth *',
//                       icon: PhosphorIconsFill.calendar,
//                       hintText: 'Select your Date of Birth',
//                       Controller: _dobtController,
//                       readOnly: true,
//                       onTap: () async {
//                         _selectDate(context);
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select your date of birth';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: buildADDField(
//                       label: 'Age *',
//                       icon: PhosphorIconsFill.user,
//                       hintText: 'your Age',
//                       Controller: _agetController,
//                       readOnly: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select your date of birth';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               buildADDField(
//                 label: 'Email Id',
//                 icon: PhosphorIconsFill.envelope,
//                 hintText: 'Enter Email Id',
//                 Controller: _emailController,
//                 keybordType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return null;
//                   }
//                   if (!RegExp(
//                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                   ).hasMatch(value)) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),

//               buildDropdown(
//                 label: "Profile Created by *",
//                 onChanged: (newvalue) {
//                   setState(() {
//                     _selectedProfile = newvalue;
//                   });
//                 },
//                 context: context,
//                 options: Profileoptions.map((e) => e).toList(),
//                 hintText: "Select Profile Created by",
//                 selectedValue: _selectedProfile,
//                 icon: PhosphorIconsFill.userCircle,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select Profile Created by';
//                   }
//                   return null;
//                 },
//               ),

//               SizedBox(height: 20.h),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   buildNextButton(
//                     onTap: () {
//                       if (_page1FormKey.currentState?.validate() ?? false) {
//                         _pageController.nextPage(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }