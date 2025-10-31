import 'dart:ui';
import 'package:agent_porta/pages/home_page.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({super.key});

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(color: kBackgroundColor),
          ),
          Positioned.fill(
            child: Lottie.asset(
              "assets/json/Confetti (1).json",
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 24 + padding.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 80.h),
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 10,
                              color: kPrimaryColor.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: kPrimaryColor,
                          size: 80,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Text(
                        "Congratulation 🎉",
                        style: GTextStyle.heading1Bold.copyWith(
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        'Your account has been verified successfully!\nYou can now access all features.',
                        style: GTextStyle.bodyBold.copyWith(
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Container(
                          width: 120.w,
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
            ),
          ),
        ],
      ),
    );
  }
}
