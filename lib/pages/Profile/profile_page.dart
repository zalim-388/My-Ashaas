import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/Profile/agent_details.dart';
import 'package:my_ashaas/pages/Profile/request_money.dart';
import 'package:my_ashaas/pages/Profile/wallet_page.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

import 'bank_details_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,

        centerTitle: false,
        title: Text('Profile', style: GTextStyle.heading1Medium),
        leading: IconButton(
          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 18.spMin,
            color: kArrowBackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Profile card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 23.w),
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kBlackPrimary.withOpacity(.7), kBlackPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                //  color:   kContainerBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: kContainerBgColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: Image.asset(
                            '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return PhosphorIcon(
                                PhosphorIconsLight.detective,
                                duotoneSecondaryColor: Colors.white,
                                duotoneSecondaryOpacity: 0.4,
                                size: 25.spMin,
                                color: kIconColor,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: GTextStyle.bodyMedium.copyWith(color: white),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Agent ID: 4578420',
                            style: GTextStyle.bodySmall.copyWith(color: white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CryptoWalletScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: isLandscape ? 100.w : 230.w,
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: isLandscape ? 8.w : 20.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: Colors.white24,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/wallet1.png',
                              height: 40.h,
                              width: 40.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.wallet,
                                  color: white,
                                  size: 32.spMin,
                                );
                              },
                            ),

                            SizedBox(width: isLandscape ? 8.w : 20.w),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    'Wallet Balance',
                                    style: GTextStyle.bodyLight.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '100,000',
                                    style: GTextStyle.bodySmallbold.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 4.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Settings",
                    style: GTextStyle.bodyMedium.copyWith(color: kTextPrimary),
                  ),
                  SizedBox(height: 8.h),
                  _buildMenuItem(
                    context: context,
                    icon: PhosphorIconsLight.userFocus,
                    showArrow: true,
                    title: 'Agent Details',
                    subtitle: 'View your profile details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgentDetails(image: ''),
                        ),
                      );
                    },
                  ),

                  _buildMenuItem(
                    context: context,
                    showArrow: true,
                    imagePath: 'assets/images/save-money.png',
                    title: 'Request Money ',
                    subtitle: 'Request money from My Ashaa\'s -a',
                    onTap: () {
                      RequestMoneyDialog.show(context);
                    },
                  ),

                  _buildMenuItem(
                    context: context,
                    showArrow: true,
                    icon: PhosphorIconsThin.bank,
                    title: 'Bank Details',
                    subtitle: 'View your bank details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankDetailsPage(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    showArrow: false,
                    icon: PhosphorIconsLight.mapPinArea,
                    title: 'Area / Location',
                    subtitle: 'Kottakkal',
                    trailing: Text(
                      "Kottakkal",
                      style: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
                    ),
                  ),
                  _buildMenuItem(
                    context: context,
                    imagePath: 'assets/images/logout.png',
                    title: 'Logout',
                    showArrow: true,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: kBackgroundColor1,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isLandScape ? 100.w : 40.w,
            vertical: 30.h,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Log Out', style: GTextStyle.heading1.copyWith()),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure you want to log out?',
                  style: GTextStyle.bodySmall.copyWith(),
                ),
                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: GTextStyle.button.copyWith(),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Log Out',
                        style: GTextStyle.button.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildMenuItem({
  String? imagePath,
  IconData? icon,
  required String title,
  String? subtitle,
  VoidCallback? onTap,
  double? size,
  bool showArrow = false,
  Widget? trailing,
  required BuildContext context,
}) {
  final isLandScape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),

        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: isLandScape ? 4.w : 14.w,
          ),
          decoration: BoxDecoration(
            color: onTap != null ? kContainerBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          // alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   padding: EdgeInsets.all(10.w),
              //   decoration: BoxDecoration(
              //     color: kPrimaryColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(12.r),
              //   ),
              //   child:
              Container(
                width: 35.w,
                alignment: Alignment.center,
                child:
                    imagePath != null
                        ? Image.asset(
                          imagePath,
                          width: 24.w,
                          height: 24.h,
                          color:
                              title == 'Logout'
                                  ? Colors.red.shade200
                                  : kIconColor,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  icon != null
                                      ? Icon(
                                        icon,
                                        size: 26.spMin,
                                        color: kIconColor,
                                      )
                                      : const SizedBox.shrink(),
                        )
                        : Icon(
                          icon,
                          size: size ?? 24.spMin,
                          color:
                              title == "Logout"
                                  ? Colors.red.shade200
                                  : kIconColor,
                        ),
              ),

              //  icon != null
              // SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GTextStyle.bodyBold.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: GTextStyle.bodySmall.copyWith(
                          color: kTextOnPrimary,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
              if (showArrow && trailing == null)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: isLandScape ? 10.sp : 20.sp,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
