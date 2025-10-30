import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/pages/verify_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MoblieScreen());
  }
}

class MoblieScreen extends StatefulWidget {
  const MoblieScreen({super.key});

  @override
  State<MoblieScreen> createState() => _MoblieScreenState();
}

class _MoblieScreenState extends State<MoblieScreen> {
  String? _selectedCountryCode = "+91";
  String? _selectedCountryFlag;

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
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        bottomSheetHeight: 600.h,
        flagSize: 21.r,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 170.w),

              buildlogo(),
              SizedBox(height: 30.h),

              Align(
                alignment: Alignment.centerLeft,

                child: Text("Moblie Number", style: GTextStyle.bodyMedium),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _openCountryPicker,
                    child: Container(
                      height: 40.h,
                      padding: EdgeInsets.all(9.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: kPrimaryColor, width: 1.w),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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

                  SizedBox(width: 8.w),

                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.w, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Your Moblie Number",
                          hintStyle: GTextStyle.bodyLight,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
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
                    DialogRoute(
                      context: context,
                      builder: (context) => VerifyScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Continue',
                    style: GTextStyle.bodyBold.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
