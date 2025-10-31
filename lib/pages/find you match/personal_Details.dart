import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/constants.dart' as Colors;
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Widget buildpersonalDetails(
  PageController _pageController,
  GlobalKey<FormState> key,
  TextEditingController _heightController,
  TextEditingController _weightController,
  TextEditingController _ReligionController,
  TextEditingController _BloodGroupController, {
  required Function(String?) onMaritalStatusChanged,
  required String selectedMaritalStatus,
  required List<String> MaritalStatuisoptions,
  required BuildContext context,
  required Function(String?) onMotherTohgueChanged,
  required String selectedMotherTongue,
  required List<String> MotherTongueOptions,
}) {
  return Form(
    key: key,

    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),

      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "personal details",
              style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
            ),
            SizedBox(height: 20.h),

            buildADDField(
              label: 'Height (in cm/ft) *',
              icon: PhosphorIconsFill.ruler,
              hintText: 'Enter your height',
              Controller: _heightController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter you heigth';
                }
                return null;
              },
            ),
            buildADDField(
              label: 'weight (in Kg) *',
              icon: PhosphorIconsFill.barbell,
              hintText: 'Enter your weight',
              Controller: _weightController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter you weight';
                }
                return null;
              },
            ),
            buildDropdown(
              label: "Marital Status",
              hintText: "Select Marital Status",
              icon: PhosphorIconsFill.heart,
              context: context,
              options: MaritalStatuisoptions,
              selectedValue: selectedMaritalStatus,
              onChanged: onMaritalStatusChanged,
            ),
            buildDropdown(
              label: "Mother Tongue",
              hintText: "Select Mother Tongue",
              icon: PhosphorIconsFill.globeStand,
              context: context,
              options: MotherTongueOptions,
              selectedValue: selectedMotherTongue,
              onChanged: onMotherTohgueChanged,
              isSearchable: true,
              // enabled: true,
            ),

            buildADDField(
              label: 'Religion',
              icon: PhosphorIconsFill.handsPraying,

              hintText: 'Enter Religion',
              Controller: _ReligionController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your Religion';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

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
      ),
    ),
  );
}





                // buildADDField(
                //   label: 'Mobile Number',
                //   icon: UIcons.regularRounded.mobile_notch,
                //   hintText: 'Enter 10 digit mobile number',
                //   keybordType: TextInputType.phone,

                //   Controller: _contactNumberController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter mobile number';
                //     }
                //     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                //       return 'Enter a valid 10-digit phone number';
                //     }
                //     return null;
                //   },
                // ),



                // buildADDField(
                //   label: 'State',
                //   icon: PhosphorIconsFill.globeStand,
                //   hintText: 'Enter state',
                //   Controller: _stateController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter state';
                //     }
                //     return null;
                //   },
                // ),

                // buildADDField(
                //   label: 'Country',
                //   icon: PhosphorIconsFill.globeHemisphereEast,
                //   hintText: 'Enter country',
                //   Controller: _countryController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter country';
                //     }
                //     return null;
                //   },
                // ),

                // buildADDField(
                //   label: 'GST Number',
                //   icon: PhosphorIconsFill.pencilSimpleLine,
                //   hintText: 'Enter GST number',
                //   Controller: _gstNumberController,
                //   textCapitalization: TextCapitalization.characters,
                //   validator: (value) {
                //     if (value != null &&
                //         value.isNotEmpty &&
                //         !RegExp(
                //           r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
                //         ).hasMatch(value)) {
                //       return 'Invalid GST format';
                //     }
                //     return null;
                //   },
                // ),

                // buildADDField(
                //   label: 'Aadhaar Number',
                //   icon: PhosphorIconsFill.creditCard,
                //   hintText: 'Enter Aadhaar number',
                //   Controller: _aadhaarNumberController,
                //   keybordType: TextInputType.number,
                //   validator: (value) {
                //     if (value != null &&
                //         value.isNotEmpty &&
                //         !RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                //       return 'Invalid Aadhaar format';
                //     }
                //     return null;
                //   },
                // ),

                // buildADDField(
                //   label: 'Nominee Name',
                //   icon: PhosphorIconsFill.userCircle,
                //   hintText: 'Enter nominee Name',
                //   Controller: _nomineeController,
                //   keybordType: TextInputType.name,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter nominee name';
                //     }
                //     return null;
                //   },
                // ),

                // buildADDField(
                //   label: 'Nominee Number',
                //   icon: PhosphorIconsRegular.numpad,
                //   hintText: 'Enter nominee 10 digit mobile number',
                //   Controller: _nomineeNumberController,
                //   keybordType: TextInputType.phone,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter nominee mobile number';
                //     }
                //     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                //       return 'Enter a valid 10-digit phone number';
                //     }
                //     return null;
                //   },
                // ),
                // buildFieldLabel(
                //   label: 'Upload Pictures (Min: $_minFiles, Max: $_maxFiles)',
                //   icon: PhosphorIconsFill.upload,
                // ),
                // InkWell(
                //   borderRadius: BorderRadius.circular(10),
                //   onTap: _pickFiles,
                //   child: Container(
                //     height: 120.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.r),
                //       color: Colors.grey.shade100,
                //     ),
                //     child:
                //         _selectedFiles.isEmpty
                //             ? Center(
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Icon(
                //                     Ionicons.image,
                //                     size: 40,
                //                     color: Colors.black38,
                //                   ),
                //                   SizedBox(height: 8.h),
                //                   Text(
                //                     'Tap to capture or upload pictures',
                //                     style: TextStyle(
                //                       fontFamily: 'qs',
                //                       fontWeight: FontWeight.w500,
                //                       color: Colors.grey,
                //                       fontSize: 12.sp,
                //                     ),
                //                   ),
                //                   Text(
                //                     'Min: $_minFiles, Max: $_maxFiles files',
                //                     style: TextStyle(
                //                       fontFamily: 'qs',
                //                       fontSize: 11.sp,
                //                       color: Colors.grey,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             )
                //             : Center(
                //               child: SingleChildScrollView(
                //                 scrollDirection: Axis.horizontal,
                //                 padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                //                 child: Row(
                //                   children:
                //                       _selectedFiles.asMap().entries.map((
                //                         entry,
                //                       ) {
                //                         int index = entry.key;
                //                         File file = entry.value;
                //                         return Container(
                //                           margin: EdgeInsets.only(right: 8),
                //                           child: Stack(
                //                             children: [
                //                               ClipRRect(
                //                                 borderRadius:
                //                                     BorderRadius.circular(8.r),
                //                                 child: Image.file(
                //                                   file,
                //                                   width: 80.w,
                //                                   height: 80.h,
                //                                   fit: BoxFit.cover,
                //                                 ),
                //                               ),
                //                               Positioned(
                //                                 top: 4,
                //                                 right: 4.w,
                //                                 child: GestureDetector(
                //                                   onTap:
                //                                       () => _removeFile(index),
                //                                   child: Container(
                //                                     padding: EdgeInsets.all(
                //                                       5.w,
                //                                     ),
                //                                     decoration: BoxDecoration(
                //                                       color: kPrimaryColor,
                //                                       borderRadius:
                //                                           BorderRadius.circular(
                //                                             10,
                //                                           ),
                //                                     ),
                //                                     child: Icon(
                //                                       Ionicons.trash_outline,
                //                                       color: Colors.white,
                //                                       size: 14.sp,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         );
                //                       }).toList(),
                //                 ),
                //               ),
                //             ),
                //   ),
                // ),

                // if (_selectedFiles.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 8.0, left: 10),
                //     child: Text(
                //       '${_selectedFiles.length} file(s) selected',
                //       style: TextStyle(
                //         fontSize: 12.sp,
                //         color: Colors.grey[600],
                //         fontFamily: 'qs',
                //       ),
                //     ),
                //   ),

                // SizedBox(height: 24.h),

                // GestureDetector(
                //   onTap: () {},

                //   // _isLoading ? null : _submitForm,
                //   child: Container(
                //     height: 40.h,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [
                //           kPrimaryColor.withOpacity(0.65),
                //           kPrimaryColor,
                //         ],
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         stops: [0.0, 0.9],
                //         tileMode: TileMode.decal,
                //       ),
                //       borderRadius: BorderRadius.circular(30.r),
                //     ),
                //     child:
                //         _isLoading
                //             ? SizedBox(
                //               height: 20.h,
                //               width: 20.w,
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //                 strokeWidth: 2,
                //               ),
                //             )
                //             : Text(
                //               'SUBMIT',
                //               style: GTextStyle.bodyBold.copyWith(
                //                 fontSize: 18.sp,
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w800,
                //               ),
                //             ),
                //   ),
                // ),

                // SizedBox(height: 10.h),