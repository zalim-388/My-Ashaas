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
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          Container(color: Colors.black.withOpacity(0.6)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(color: Colors.transparent),
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
                  padding: EdgeInsets.fromLTRB(
                    24.w,
                    32.h,
                    24.w,
                    24.h + padding.bottom,
                  ),
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
                              spreadRadius: 10.r,
                              color: kPrimaryColor.withOpacity(0.5),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: kPrimaryColor,
                          size: 80.spMin,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Text(
                        "Congratulation 🎉",
                        style: GTextStyle.heading1Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        'Your account has been verified successfully!\nYou can now access all features.',
                        style: GTextStyle.bodyBold.copyWith(
                          color: Colors.grey[400],
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
                            style: GTextStyle.button.copyWith(
                              color: Colors.white,
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
