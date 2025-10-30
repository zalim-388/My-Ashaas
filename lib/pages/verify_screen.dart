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

  @override
  void initState() {
    super.initState();
    for (var node in _verifyfocusnode) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _verifycontroller) {
      controller.dispose();
    }
    for (var node in _verifyfocusnode) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 110.h),
            buildlogo(),
            SizedBox(height: 10.h),

            Text(
              "Verify Your Code",
              style: GTextStyle.heading2Light.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 6.h),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GTextStyle.bodyBold.copyWith(
                  color: black,
                  fontSize: 12.0.sp,
                ),
                children: const [
                  TextSpan(text: 'Enter the 6 -digit code sent to\n'),
                  TextSpan(text: '+91 5485627345'),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: List.generate(6, (index) {
                  bool _isFcous = _verifyfocusnode[index].hasFocus;
                  return Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color:
                            (_isFcous ||
                                    _verifycontroller[index].text.isNotEmpty)
                                ? kPrimaryColor
                                : Colors.grey,
                        width: 1.w,
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
                        fontSize: 18.sp,
                      ),
                      cursorColor: kPrimaryColor,
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
                          ).requestFocus(_verifyfocusnode[index + -1]);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    DialogRoute(
                      context: context,
                      builder: (context) => setpassword(),
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
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'verify',
                    style: GTextStyle.bodyBold.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
