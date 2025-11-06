import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/pages/verify_screen.dart';

class MoblieScreen extends StatefulWidget {
  const MoblieScreen({super.key});

  @override
  State<MoblieScreen> createState() => _MoblieScreenState();
}

class _MoblieScreenState extends State<MoblieScreen> {
  String? _selectedCountryCode = "+91";
  String? _selectedCountryFlag = '🇮🇳';

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        setState(() {
          _selectedCountryCode = country.phoneCode;
          _selectedCountryFlag = country.flagEmoji;
        });
      },

      showWorldWide: true,
      showSearch: true,
      searchAutofocus: true,

      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        bottomSheetHeight: 600.h,
        flagSize: 21.r,
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 1.0.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 1.0.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 1.0.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        searchTextStyle: GTextStyle.bodyBold.copyWith(color: kPrimaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isLandscape ? 40.h : 170.w),

                buildlogo(),
                SizedBox(height: isLandscape ? 15.h : 25.h),

                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Moblie Number",
                    style: GTextStyle.label.copyWith(color: kPrimaryColor),
                  ),
                ),
                SizedBox(height: isLandscape ? 4.h : 8.h),
                Row(
                 
                  children: [
                    GestureDetector(
                      onTap: _openCountryPicker,
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.all(9.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,

                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: isLandscape ? 0.9 : 1.0.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                         mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_selectedCountryFlag != null &&
                                _selectedCountryFlag!.isNotEmpty) ...[
                              Text(
                                _selectedCountryFlag!,
                                style: GTextStyle.bodyLight,
                              ),
                              SizedBox(width: 6.w),
                            ],
                            Text(
                              (_selectedCountryCode != null)
                                  ? (_selectedCountryCode!.startsWith('+')
                                      ? _selectedCountryCode!
                                      : '+${_selectedCountryCode}')
                                  : '+91',
                              textAlign: TextAlign.center,
                              style: GTextStyle.bodyLight,
                            ),
                            SizedBox(width: 5.w),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: isLandscape ? 4.w : 8.w),

                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: ShapeDecoration(
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: isLandscape ? 0.9 : 1.0.w,
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: kPrimaryColor,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Enter Your Moblie Number",
                            hintStyle: GTextStyle.bodyLight.copyWith(
                              color: Colors.black45,
                              fontSize: isLandscape ? 8.sp : 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: isLandscape ? 9.h : 11.h,
                            ),
                            alignLabelWithHint: true,
                            isCollapsed: true,
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),

                          cursorHeight: isLandscape ? 25.h : 25,
                          style: GTextStyle.bodyBold.copyWith(
                            color: kPrimaryColor,
                            fontSize: isLandscape ? 14 : 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50.h),

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor.withOpacity(0.610),
                          kPrimaryColor,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Continue',
                      style: GTextStyle.bodyBold.copyWith(
                        fontSize: isLandscape ? 11.sp : 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
