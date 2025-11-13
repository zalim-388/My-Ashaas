import 'package:agent_porta/pages/Forget%20password/forget_pasword.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uicons/uicons.dart';
import '../../styles/constants.dart';
import 'Enter_new_pass.dart';

class ResetPasswordVerify extends StatefulWidget {
  final String otp;

  const ResetPasswordVerify({super.key, required this.otp});

  @override
  _ResetPasswordVerifyState createState() => _ResetPasswordVerifyState();
}

class _ResetPasswordVerifyState extends State<ResetPasswordVerify> {
  final List<TextEditingController> _verifycontroller = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _verifyfocusnode = List.generate(
    6,
    (index) => FocusNode(),
  );

  final _formKey = GlobalKey<FormState>();
  // bool _pinSuccess = false;
  // String _enteredOtp = '';

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isLandscape ? 30.h : 35.h),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  );
                },

                icon: Icon(
                  UIcons.solidRounded.angle_left,
                  size: 18.spMin,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: isLandscape ? 30.h : 110.h),
              buildlogo(),
              SizedBox(height: 30.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Check your SMS ',
                      style: GTextStyle.display.copyWith(
                        color: kPrimaryColor,
                        fontSize: 28.spMin,
                      ),
                      // style: GoogleFonts.poppins(
                      //   color: kPrimaryColor,
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: isLandscape ? 40 : 28.sp,
                      //   letterSpacing: 0.5,
                      // ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'We sent a code to +91 *******901',
                      style: GTextStyle.bodyMedium.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isLandscape ? 15.h : 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLandscape ? 100.w : 43.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: List.generate(6, (index) {
                          bool _isFcous = _verifyfocusnode[index].hasFocus;
                          return Container(
                            height: isLandscape ? 50.h : 40.h,
                            width: isLandscape ? 20.w : 40.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,

                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color:
                                    (_isFcous ||
                                            _verifycontroller[index]
                                                .text
                                                .isNotEmpty)
                                        ? kPrimaryColor
                                        : Colors.grey,
                                width: isLandscape ? 0.9 : 1.w,
                              ),
                            ),
                            child: TextField(
                              controller: _verifycontroller[index],
                              focusNode: _verifyfocusnode[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                counterText: '',
                              ),
                              style: GTextStyle.bodyBold.copyWith(
                                color: kPrimaryColor,
                                fontSize: isLandscape ? 11.sp : 18.sp,
                              ),
                              cursorColor: kPrimaryColor,
                              cursorHeight: isLandscape ? 30.h : 25,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                if (value.length == 1 && index < 5) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_verifyfocusnode[index + 1]);
                                }
                                if (value.isEmpty && index > 0) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_verifyfocusnode[index - 1]);
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 45.h),

                    buildButton(
                      title: 'Continue',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnterNewPass(otp: ''),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "If you didn't receive a code! ",
                              style: GTextStyle.bodyLight.copyWith(
                                color: Colors.black38,
                              ),
                            ),
                            TextSpan(
                              text: 'Resend',
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return ThemeHelper().alartDialog(
                                      //       "Successful",
                                      //       "Verification code resend successful.",
                                      //       context,
                                      //     );
                                      //   },
                                      // );
                                    },
                              style: GTextStyle.bodySmallbold.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
