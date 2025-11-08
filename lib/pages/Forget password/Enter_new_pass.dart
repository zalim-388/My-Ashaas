import 'dart:convert';

import 'package:agent_porta/pages/Congratulation.dart';
import 'package:agent_porta/pages/set_pasaword.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/styles/theme_helper.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EnterNewPass extends StatefulWidget {
  final String otp;
  const EnterNewPass({Key? key, required this.otp}) : super(key: key);

  @override
  _EnterNewPassState createState() => _EnterNewPassState();
}

class _EnterNewPassState extends State<EnterNewPass> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final String password = _passwordController.text;

      final response = await http.post(
        Uri.parse('https://api.malabarbank.in/api/verifyOtpAndUpdatePassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'password': password}),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setpassword()),
        );
      } else {
        // Handle error response
        print('Failed to update password.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text(
                    'Create new password',
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Your new password must be different from the old one',
                    style: GTextStyle.bodyMedium.copyWith(
                      fontSize: 15.sp,

                      color: Colors.black54,
                    ),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        buildADDField(
                          hintText: "Enetr new password",
                          Controller: _passwordController,
                          label: "Password",
                          context: context,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Password can't be empty";
                            }
                            if (val.length < 8) {
                              return "Password must be at least 8 characters long";
                            }
                            return null;
                          },
                          showBorderside: true,
                        ),

                        buildADDField(
                          label: "Confirm Password",
                          hintText: "Re-Enter new password",
                          Controller: _confirmPasswordController,
                          context: context,

                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Password can't be empty";
                            }
                            if (val != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          showBorderside: true,
                        ),

                        SizedBox(height: 40.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Congratulation(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  kPrimaryColor.withOpacity(0.610),
                                  kPrimaryColor,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Save & Continue',
                              style: GTextStyle.bodyBold.copyWith(
                                fontSize: isLandscape ? 8.sp : 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
