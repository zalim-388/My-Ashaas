import 'package:agent_porta/pages/moblie_screen.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Reset_password_verify.dart';
import '../set_pasaword.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  // Future<void> _sendPasswordResetRequest() async {
  //   final email = _emailController.text;
  //   final url = Uri.parse(
  //     'https://api.malabarbank.in/api/requestpasswordupdate',
  //   );

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'email': email}),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       final otp = responseData['otp'];
  //       print('machu: $otp');

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ForgotPasswordVerificationPage(otp: otp),
  //         ),
  //       );
  //     } else {
  //       // Show an error message if something went wrong
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to send reset email. Please try again.'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred. Please try again.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Setpassword()),
            );
          },
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),

          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
            size: isLandscape ? 25 : 20.sp,
          ),
        ),
        backgroundColor: kBackgroundColor,

        centerTitle: false,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Forgot\nPassword?',
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: isLandscape ? 40 : 30.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Don\'t worry! It happens. Please enter the email address\nassociated with your account.',
                    style: GTextStyle.bodyMedium.copyWith(
                      color: Colors.black54,
                      // fontFamily: "Outfit",
                    ),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        buildADDField(
                          label: "Phone Number",
                          hintText: "Enter phone Number",
                          Controller: _phoneController,
                          context: context,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter phone number';
                            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },
                          showBorderside: true,
                          keybordType: TextInputType.number,
                        ),

                        SizedBox(height: 32.h),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ResetPasswordVerify(
                                      otp: '2323',
                                    ),
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
                              'Rest Password',
                              style: GTextStyle.bodyBold.copyWith(
                                fontSize: isLandscape ? 8.sp : 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Remember your password? ",
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: isLandscape ? 7.sp : 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Login',
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MoblieScreen(),
                                          ),
                                        );
                                      },
                                style: GTextStyle.bodyBold.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
