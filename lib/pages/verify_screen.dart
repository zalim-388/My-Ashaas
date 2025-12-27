import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/Referral_page.dart';
import 'package:my_ashaas/pages/mobile_screen.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:my_ashaas/widgets/buttons.dart';
import 'package:my_ashaas/widgets/logo.dart';
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

  //MARK:- mskEmail
  String mskEmail(String email) {
    final parts = email.split("@");
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];

    final visible = name.length > 3 ? name.substring(0, 3) : name[0];
    return "$visible****@$domain";
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
    //MARK:-Appbar
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isLandscape ? 48.h : 56.h),
        child: buildAppbar(
          appbarColor: kBackgroundColor,
          onPressedLeading: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MobileScreen()),
            );
          },
        ),
      ),

      body: _mainbody(isLandscape),
    );
  }

  Widget _mainbody(bool isLandscape) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: isLandscape ? 20.h : 110.h),
            buildlogo(),
            SizedBox(height: isLandscape ? 15.h : 10.h),

            Text(
              "Verify Your Code",
              style: GTextStyle.heading2Bold.copyWith(color: kTextblod),
            ),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GTextStyle.bodySmall.copyWith(
                  color: kTextPrimary,
                  // fontSize: isLandscape ? 8.sp : 12.sp,
                ),
                children: [
                  const TextSpan(text: 'Enter the 6 -digit code sent to\n'),
                  TextSpan(text: mskEmail("ashass123@gmail.com")),
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
                    alignment: Alignment.center,
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
                        contentPadding: EdgeInsets.symmetric(
                          vertical: isLandscape ? 8.h : 8.h,
                        ),
                        counterText: '',
                      ),
                      style: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
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

            SizedBox(height: 40.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: buildButtions(
                context: context,
                label: 'verify',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ReferralPage()),
                  );
                },
              ),
            ),

            SizedBox(height: 15.h),

            RichText(
              text: TextSpan(
                text: "Didn't get OTP? ",
                style: GTextStyle.bodySmall.copyWith(color: kTextSecondary),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: isResendDisable ? null : resendOtp,
                      child: Text(
                        isResendDisable ? "Resend in $_conutdowm" : 'Resend',
                        style: GTextStyle.bodySmallbold.copyWith(
                          color: isResendDisable ? kTextSecondary : kTextblod,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isLandscape ? 30.h : 20.h),
          ],
        ),
      ),
    );
  }
}
