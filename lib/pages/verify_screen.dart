import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/mobile_screen.dart';
import 'package:my_ashaas/pages/set_pasaword.dart';
import 'package:my_ashaas/widgets/logo.dart';
import 'package:uicons/uicons.dart';
import 'package:my_ashaas/styles/constants.dart';
import '../styles/style.dart';

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
  int _conutdowm = 60;
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

  void resendOtp() {
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
      appBar:
          isLandscape
              ? null
              : AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MobileScreen()),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),

                  icon: Icon(
                    UIcons.solidRounded.angle_left,
                    size: 18.spMin,
                    color: kArrowBackColor,
                  ),
                ),
                backgroundColor: kBackgroundColor,
                scrolledUnderElevation: 0,
                elevation: 0,
                centerTitle: false,
              ),
      body:
          isLandscape
              ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: kBackgroundColor,
                      pinned: true,
                      elevation: 0,
                      expandedHeight: 0.h,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MobileScreen(),
                            ),
                          );
                        },

                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kArrowBackColor
                          ,
                          size: 20.spMin,
                        ),
                      ),
                      scrolledUnderElevation: 0,
                      centerTitle: false,
                      toolbarHeight: 56.h,
                    ),
                  ];
                },

                body: _mainbody(isLandscape),
              )
              : _mainbody(isLandscape),
    );
  }

  Widget _mainbody(bool isLandscape) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: isLandscape ? 20.h : 120.h),
            buildlogo(),
            SizedBox(height: isLandscape ? 15.h : 10.h),

            Text(
              "Verify Your Code",
              style: GTextStyle.heading2Bold.copyWith(color: Color(0xFF2C2C2C)),
            ),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GTextStyle.bodySmall.copyWith(
                  color: black,
                  // fontSize: isLandscape ? 8.sp : 12.sp,
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
                horizontal: isLandscape ? 100.w : 45.w,
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
                                    _verifycontroller[index].text.isNotEmpty)
                                ? kTextFieldBorder
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
                        color: kTextPrimary,
                        // fontSize: isLandscape ? 11.sp : 18.sp,
                      ),
                      cursorColor: kTextFieldBorder,
                      cursorHeight: isLandscape ? 30.h : 25.h,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Setpassword()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 45.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kBlackPrimary.withOpacity(0.610), kBlackPrimary],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'verify',
                    style: GTextStyle.button.copyWith(
                      // fontSize: isLandscape ? 11.sp : 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),

            RichText(
              text: TextSpan(
                text: "Didn't get OTP? ",
                style: GTextStyle.bodySmall.copyWith(
                  // fontSize: isLandscape ? 8.sp : 13.sp,
                  color: Colors.black54,
                ),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: isResendDisable ? null : resendOtp,
                      child: Text(
                        isResendDisable ? "Resend in $_conutdowm" : 'Resend',
                        style: GTextStyle.bodySmallbold.copyWith(
                          // fontSize: isLandscape ? 8.sp : 14.sp,
                          color: isResendDisable ? grey : kTextPrimary,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text("Didn't get OTP? ", style: GTextStyle.bodyMedium),
            //     TextButton(
            //       style: TextButton.styleFrom(
            //         minimumSize: Size(50, 30),
            //         padding: EdgeInsets.zero,
            //       ),
            //       onPressed: isResendDisable ? null : resendOtp,
            //       child: Text(
            //         isResendDisable ? "Resend in $_conutdowm" : 'Resend',
            //         style: GTextStyle.bodyBold.copyWith(
            //           color: isResendDisable ? grey : kPrimaryColor,
            //           fontWeight: FontWeight.w800,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
