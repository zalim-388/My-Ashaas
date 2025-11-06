import 'dart:async';

import 'package:agent_porta/pages/moblie_screen.dart';
import 'package:agent_porta/pages/set_pasaword.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<TextEditingController> _verifycontroller = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _verifyfocusnode = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _conutdowm = 30;
  bool isResendDisable = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (var node in _verifyfocusnode) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer!.cancel();

    for (var controller in _verifycontroller) {
      controller.dispose();
    }
    for (var node in _verifyfocusnode) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    isResendDisable = true;
    _conutdowm = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_conutdowm > 0) {
        setState(() {
          _conutdowm--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          isResendDisable = false;
        });
      }
    });
  }

  void ResendOtp() {
    print('Resend Otp.....');
    setState(() {
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => MoblieScreen()),
      //       );
      //     },
      //     padding: EdgeInsets.zero,

      //     icon: Icon(Icons.arrow_back_ios, color: black, size: 20),
      //   ),
      //   backgroundColor: kBackgroundColor,

      //   elevation: isLandscape ? 0 : 1,
      //   centerTitle: false,
      //   toolbarHeight: isLandscape ? 30.h : 56.h,
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MoblieScreen()),
                  );
                },
                padding: EdgeInsets.zero,

                icon: Icon(Icons.arrow_back_ios, color: black, size: 20),
              ),
              backgroundColor: kBackgroundColor,

              elevation: isLandscape ? 0 : 1,
              centerTitle: false,
              toolbarHeight: isLandscape ? 30.h : 56.h,
            ),
          ];
        },
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isLandscape ? 30.h : 60.h),
                buildlogo(),
                SizedBox(height: isLandscape ? 15.h : 10.h),

                Text(
                  "Verify Your Code",
                  style: GTextStyle.heading2Light.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isLandscape ? 12.sp : 20.sp,
                  ),
                ),
                SizedBox(height: isLandscape ? 4.h : 6.h),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GTextStyle.bodyBold.copyWith(
                      color: black,
                      fontSize: isLandscape ? 8.sp : 12.sp,
                    ),
                    children: const [
                      TextSpan(text: 'Enter the 6 -digit code sent to\n'),
                      TextSpan(text: '+91 5485627345'),
                    ],
                  ),
                ),

                SizedBox(height: isLandscape ? 15.h : 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? 85.w : 45.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: List.generate(6, (index) {
                      bool _isFcous = _verifyfocusnode[index].hasFocus;
                      return Container(
                        height: isLandscape ? 50.h : 40.h,
                        width: isLandscape ? 25.w : 40.w,
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

                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => setpassword()),
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
                        'verify',
                        style: GTextStyle.bodyBold.copyWith(
                          fontSize: isLandscape ? 11.sp : 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn't get OTP? ", style: GTextStyle.bodyMedium),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(50, 30),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: isResendDisable ? null : ResendOtp,
                      child: Text(
                        isResendDisable ? "Resend in $_conutdowm" : 'Resend',
                        style: GTextStyle.bodyBold.copyWith(
                          color: isResendDisable ? grey : kPrimaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
