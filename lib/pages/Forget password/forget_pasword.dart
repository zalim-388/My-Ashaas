import 'package:agent_porta/pages/mobile_screen.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uicons/uicons.dart';

import '../../styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 18.spMin,
            color: kArrowBackColor,
          ),
        ),
        backgroundColor: kBackgroundColor,

        centerTitle: false,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    'Forgot\nPassword?',
                    style: GTextStyle.display.copyWith(color: kTextPrimary),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Don\'t worry! It happens. Please enter the email address\nassociated with your account.',
                    style: GTextStyle.bodyMedium.copyWith(
                      color: Colors.black54,
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
                        buildButton(
                          title: 'Rest Password',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ResetPasswordVerify(otp: '2323'),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 30.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Remember your password? ",
                                style: GTextStyle.bodyLight.copyWith(),
                              ),
                              TextSpan(
                                text: 'Login',
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => MobileScreen(),
                                          ),
                                        );
                                      },
                                style: GTextStyle.bodyBold.copyWith(
                                  color: kTextOnPrimary
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
