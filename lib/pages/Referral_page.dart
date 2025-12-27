import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/set_pasaword.dart';
import 'package:my_ashaas/pages/verify_screen.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:my_ashaas/widgets/buttons.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({super.key});

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  final _referralControllaer = TextEditingController();
  final _phoneNumberControllaer = TextEditingController();

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
          onPressedLeading: () {
               Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VerifyScreen()),
            );
          },
          titleText: "Referral",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: isLandscape ? 60.h : 150.h,
        ),
        child: Column(
          children: [
            buildADDField(
              label: "Referral Code",
              showBorderside: true,
              hintText: " Enter your Referral Code",
              Controller: _referralControllaer,
              context: context,
            ),
            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: Divider(color: grey.withOpacity(.40), thickness: 1.w),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "OR",
                    style: GTextStyle.bodyBold.copyWith(color: kTextSecondary),
                  ),
                ),

                Expanded(
                  child: Divider(color: grey.withOpacity(.50), thickness: 1.w),
                ),
              ],
            ),

            buildADDField(
              label: "Phone Number",
              showBorderside: true,
              hintText: " Enter your Phone Number",
              Controller: _phoneNumberControllaer,
              context: context,
            ),
            SizedBox(height: 40.h),

            //MARK:- button
            buildButtions(
              context: context,
              label: 'Continue',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setpassword()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
