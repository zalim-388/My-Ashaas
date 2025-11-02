import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
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
  TextEditingController occupationFatherController,
  TextEditingController occupationMotherController,
  TextEditingController totalbrothersController,
  TextEditingController totalsistersController,
  TextEditingController hometownController,

  BuildContext context, {
  bool? selectionFatherStatus,
  required Function(bool?) onFatherStatusChanged,
  //mother
  bool? selectionMotherStatus,
  required Function(bool?) onMotherStatusChanged,
  //family status
  required String? selectfamilystatus,
  required Function(String?) onfamilystatusChanged,
  required List<String> familystatusOptions,

  // family type
  required String? selectfamilytype,
  required Function(String?) onfamilytypeChanged,
  required List<String> familytypeOptions,

  //siblings
  String? selectBroCount,
  required Function(String?) onBroCountChanged,
  required String? selectBroMarried,
  required Function(String?) onBroMarriedChanged,
  required String? selectSisCount,
  required Function(String?) onSisCountChanged,
  String? selectSisMarried,
  required Function(String?) onSisMarriedChanged,
}) {
  final int totalBro = int.tryParse(totalbrothersController.text) ?? 0;
  final int totalSis = int.tryParse(totalsistersController.text) ?? 0;
  final List<String> BroMarriedOptions = List.generate(
    totalBro + 1,
    (i) => i.toString(),
  );
  final List<String> SisMarriedOptions = List.generate(
    totalSis + 1,
    (i) => i.toString(),
  );

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
              label: "Father Name",
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
              label: "Father Status",
              selection: selectionFatherStatus,
              onChanged: onFatherStatusChanged,
              title: "Alive",
              title1: "Late",
              icon1: Icons.person,
              icon2: Icons.bookmark,
            ),
            if (selectionFatherStatus == false)
              buildADDField(
                label: "Father Occupation",
                hintText: "Enter Father Occupation",
                Controller: occupationFatherController,
                keybordType: TextInputType.name,
                icon: Icons.work_outline,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Father Occuptation';
                  }
                  return null;
                },
              ),

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

            if (selectionMotherStatus == false)
              buildADDField(
                label: "Mother Occupation",
                hintText: "Enter Mother Occupation",
                Controller: occupationMotherController,
                keybordType: TextInputType.name,
                icon: Icons.work_outline,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Mother Occuptation';
                  }
                  return null;
                },
              ),

            buildDropdown(
              label: "Family type",
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

            Row(
              children: [
                Expanded(
                  child: buildDropdown(
                    label: "Number of brothers",
                    onChanged: onBroCountChanged,
                    selectedValue: selectBroCount,
                    controller: totalbrothersController,
                    keyboardType: TextInputType.number,
                    context: context,
                    isSearchable: true,
                    hintText: "Enter number of brothers",
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: buildDropdown(
                    label: "Numbers of Sisters",
                    onChanged: onSisCountChanged,
                    selectedValue: selectSisCount,
                    controller: totalsistersController,
                    context: context,
                    keyboardType: TextInputType.number,

                    isSearchable: true,
                    hintText: "Enter number of Sisters",
                  ),
                ),
              ],
            ),

            Row(
              children: [
                if (totalBro > 0)
                  Expanded(
                    child: buildDropdown(
                      label: "brothers are married",
                      onChanged: onBroMarriedChanged,
                      selectedValue: selectBroMarried,
                      context: context,
                      isSearchable: true,
                      hintText: "Enter brothers are married",
                      options: BroMarriedOptions,
                      keyboardType: TextInputType.number,
                    ),
                  )
                else
                  Expanded(child: Container()),

                SizedBox(width: 16.w),
                if (totalSis > 0)
                  Expanded(
                    child: buildDropdown(
                      label: "Sisters are married",
                      onChanged: onSisMarriedChanged,
                      selectedValue: selectSisMarried,
                      context: context,
                      isSearchable: true,
                      hintText: "Enter Sisters are married",
                      options: SisMarriedOptions,
                      keyboardType: TextInputType.number,
                    ),
                  )
                else
                  Expanded(child: Container()),
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
