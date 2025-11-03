import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/csc_picker.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:agent_porta/widgets/toggle_boutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Widget buildFamilyDetails(
  PageController _pageController,
  GlobalKey<FormState> key,
  TextEditingController fatherNameController,
  TextEditingController motherNameController,
  TextEditingController lateFatherController,
  TextEditingController lateMotherController,
  TextEditingController totalbrothersController,
  TextEditingController totalsistersController,
  TextEditingController totalmarriedController,
  TextEditingController hometownController,
  TextEditingController othersFatherOccuptionController,
  TextEditingController othersMotherOccuptionController,
  TextEditingController countryController,
  TextEditingController stateController,
  TextEditingController cityController,
  TextEditingController districtController,

  BuildContext context, {
  bool? selectionFatherStatus,
  required Function(bool?) onFatherStatusChanged,
  required Function(String?) onOccupationFatherChanged,
  required List<String> fatherstatusOptions,
  String? selectFatherOccupation,

  //mother
  bool? selectionMotherStatus,
  required Function(bool?) onMotherStatusChanged,
  required Function(String?) onOccupationMotherChanged,
  required List<String> motherStatusOptions,
  String? selectMotherOccupation,

  //family status
  required String? selectfamilystatus,
  required Function(String?) onfamilystatusChanged,
  required List<String> familystatusOptions,

  // family type
  required String? selectfamilytype,
  required Function(String?) onfamilytypeChanged,
  required List<String> familytypeOptions,

  // csc
  required String? selectCountry,
  required Function(String?) onCountryChanged,

  required List<String> CountryOptions,
  required String? selectState,
  required Function(String?) onStateChanged,

  required List<String> StateOptions,
  required String? selectCity,
  required Function(String?) onCityChanged,

  required List<String> CityOptions,

  required List<String> countries,
  required List<String> states,
  required List<String> cities,
  required List<String> districts,
  required Function(String?) onDistrictChanged,
  required String? selectDistrict,
}) {
  final int totalBro = int.tryParse(totalbrothersController.text) ?? 0;
  final int totalSis = int.tryParse(totalsistersController.text) ?? 0;
  return Form(
    key: key,
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
        child: Column(
          children: [
            Text(
              "Family details",
              style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
            ),

            buildADDField(
              label: "Father Name *",
              hintText: "Enter Father Name",
              Controller: fatherNameController,
              keybordType: TextInputType.name,
              icon: PhosphorIconsFill.person,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter Father Name';
                }
                return null;
              },
            ),

            buildToggle(
              label: "Father Status *",
              selection: selectionFatherStatus,
              onChanged: onFatherStatusChanged,
              title: "Alive",
              title1: "Late",
              icon1: Icons.person,
              icon2: Icons.bookmark,
            ),
            if (selectionFatherStatus == true) ...[
              buildDropdown(
                label: "Father Occupation",
                hintText: "selcet an Occupation",
                options: fatherstatusOptions,
                onChanged: onOccupationFatherChanged,
                icon: Icons.work_outline,
                context: context,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please selcet an Occuptation';
                  }
                  return null;
                },
              ),
            ],
            if (selectFatherOccupation == "Others")
              buildADDField(
                label: "Please Specfiy",
                hintText: "Enter Occupation",
                Controller: othersFatherOccuptionController,
                keybordType: TextInputType.name,
                icon: PhosphorIconsFill.pen,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please  Enter Occupation';
                  }
                  return null;
                },
              )
            else if (selectionFatherStatus == false) ...[
              buildADDField(
                label: "Which year",
                hintText: "Enter year ",
                Controller: lateFatherController,
                keybordType: TextInputType.number,
                icon: Icons.calendar_today,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter year';
                  }
                  return null;
                },
              ),
            ],

            buildADDField(
              label: "Mother Name",
              hintText: "Enter Mother Name",
              Controller: motherNameController,
              keybordType: TextInputType.name,
              icon: PhosphorIconsFill.person,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter Mother Name';
                }
                return null;
              },
            ),
            buildToggle(
              label: "Mother Status",
              selection: selectionMotherStatus,
              onChanged: onMotherStatusChanged,
              title: "Alive",
              title1: "Late",
              icon1: Icons.person,
              icon2: Icons.bookmark,
            ),

            if (selectionMotherStatus == true) ...[
              buildDropdown(
                label: "Mother Occupation",
                hintText: "select an Occupation",
                context: context,
                onChanged: onOccupationMotherChanged,
                options: motherStatusOptions,
                icon: Icons.work_outline,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please  select an Occuptation';
                  }
                  return null;
                },
              ),
            ],
            if (selectMotherOccupation == "Others")
              buildADDField(
                label: "Please Specfiy",
                hintText: "Enter Occupation",
                Controller: othersMotherOccuptionController,
                keybordType: TextInputType.name,
                icon: PhosphorIconsFill.pen,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please  Enter Occupation';
                  }
                  return null;
                },
              )
            else if (selectionMotherStatus == false) ...[
              buildADDField(
                label: "which year",
                hintText: "Enter year",
                Controller: lateMotherController,
                keybordType: TextInputType.number,
                icon: Icons.calendar_today,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter year';
                  }
                  return null;
                },
              ),
            ],

            buildDropdown(
              label: "Family type *",
              hintText: "select family type",
              onChanged: onfamilytypeChanged,
              context: context,
              options: familytypeOptions,
              icon: PhosphorIconsFill.house,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please select Family Type";
                }
                return null;
              },
            ),
            buildDropdown(
              label: 'Family Status*',
              hintText: 'select  Family Status',
              icon: Icons.family_restroom,
              selectedValue: selectfamilystatus,
              onChanged: onfamilystatusChanged,
              context: context,
              options: familystatusOptions,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null;
                }
                return null;
              },
            ),
            buildFieldLabel(label: "Sibilings"),

            Row(
              children: [
                Expanded(
                  child: buildADDField(
                    label: "Number of brothers",
                    fontSize: 12.sp,

                    Controller: totalbrothersController,
                    keybordType: TextInputType.number,
                    icon: Icons.male,
                    hintText: "Enter number of brothers",
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: buildADDField(
                    label: "Numbers of Sisters",
                    fontSize: 12.sp,
                    Controller: totalsistersController,
                    keybordType: TextInputType.number,
                    hintText: "Enter number of Sisters",
                    icon: Icons.female,
                  ),
                ),
                SizedBox(width: 5.w),

                if (totalBro > 0 || totalSis > 0)
                  Expanded(
                    child: buildADDField(
                      label: "TotalMarried Count",
                      fontSize: 12.sp,
                      Controller: totalmarriedController,
                      keybordType: TextInputType.number,
                      hintText: "Enter married Count",
                      icon: Icons.family_restroom_outlined,
                      validator: (value) {
                        final int totalMarried =
                            int.tryParse(totalmarriedController.text) ?? 0;
                        if (totalBro + totalSis < totalMarried) {
                          return 'Must be less than total siblings';
                        }
                        return null;
                      },
                    ),
                  ),
              ],
            ),

            buildADDField(
              label: "Native Place / Hometown",
              hintText: "Enter your home",
              Controller: hometownController,
              icon: PhosphorIconsFill.mapPin,
              validator: (value) {
                if (value != null || value?.isEmpty == false) {
                  return 'pleasse enter your hometown';
                }
                return null;
              },
            ),

            //  buildFieldLabel(label: ""),
            buildCscField(
              label: "Current Residence Address",
              onCountryChanged: onCountryChanged,
              onStateChanged: onStateChanged,
              onCityChanged: onCityChanged,
              cityController: cityController,
              countryController: countryController,
              stateController: stateController,
              // districtController: districtController,
              // onDistrictChanged: onDistrictChanged,
              // cities: cities,
              // countries: countries,
              // states: states,
              // districts: districts,
            ),

            // // In your Form's Column:

            // // --- 1. COUNTRY Field (Searchable) ---
            // buildDropdown(
            //   context: context,
            //   label: "Country *",
            //   hintText: "Search your country",
            //   icon: PhosphorIconsFill.mapTrifold,
            //   options: CountryOptions,
            //   controller: countryController,
            //   isSearchable: true,
            //   onChanged: onCountryChanged,
            //   validator:
            //       (value) =>
            //           (value == null || value.isEmpty)
            //               ? "Please select a country"
            //               : null,
            // ),

            // // --- 2. STATE Field (Conditional & Searchable) ---
            // // This will only appear *after* a country is selected
            // if (selectCountry != null && StateOptions.isNotEmpty)
            //   Padding(
            //     padding: EdgeInsets.only(top: 16.h),
            //     child: buildDropdown(
            //       context: context,
            //       label: "State *",
            //       hintText: "Search your state",
            //       icon: PhosphorIconsFill.mapTrifold,
            //       options: StateOptions,
            //       controller: stateController,
            //       isSearchable: true,
            //       onChanged: onStateChanged,
            //       validator:
            //           (value) =>
            //               (value == null || value.isEmpty)
            //                   ? "Please select a state"
            //                   : null,
            //     ),
            //   ),

            // // --- 3. CITY Field (Conditional & Searchable) ---
            // // This will only appear *after* a state is selected
            // if (selectState != null && CityOptions.isNotEmpty)
            //   Padding(
            //     padding: EdgeInsets.only(top: 16.h),
            //     child: buildDropdown(
            //       context: context,
            //       label: "City *",
            //       hintText: "Search your city",
            //       icon: PhosphorIconsFill.mapTrifold,
            //       options: CityOptions,
            //       controller: cityController,
            //       isSearchable: true,
            //       onChanged: onCityChanged,
            //       validator:
            //           (value) =>
            //               (value == null || value.isEmpty)
            //                   ? "Please select a city"
            //                   : null,
            //     ),
            //   ),
            SizedBox(height: 48.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildNextButton(
                  onTap: () {
                    if (key.currentState?.validate() ?? false) {
                      _pageController.nextPage(
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
