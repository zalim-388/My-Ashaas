import 'package:agent_porta/pages/Profile/agent_details.dart';
import 'package:agent_porta/pages/Profile/request_money.dart';
import 'package:agent_porta/pages/wallet_page.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          'Profile',
          style: GTextStyle.bodyBold.copyWith(
            fontSize: isLandscape ? 11.sp : 19.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 15.sp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          // Profile card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.asset(
                          '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return PhosphorIcon(
                              PhosphorIconsLight.detective,
                              duotoneSecondaryColor: kPrimaryColor,
                              duotoneSecondaryOpacity: 0.4,
                              size: 25.sp,
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: GTextStyle.bodyMedium.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          'Agent ID: 4578420',
                          style: GTextStyle.bodySmall.copyWith(
                            color: Colors.white70,
                            fontSize: 13.sp,
                          ),
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
                    width: 230.w,
                    margin: EdgeInsets.only(top: 20.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      color: Colors.white.withOpacity(0.10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/wallet1.png',
                          height: 40.sp,
                          color: white,
                        ),

                        SizedBox(width: 20.w),
                        Column(
                          children: [
                            Text(
                              'Wallet Balance',
                              style: GTextStyle.bodyLight.copyWith(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '100,000',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                  style: GTextStyle.bodyBold.copyWith(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildMenuItem(
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
                  showArrow: true,
                  imagePath: 'assets/images/save-money.png',
                  title: 'Request Money ',
                  subtitle: 'Request money from Porta',
                  onTap: () {
                    RequestMoneyDialog.show(context);
                  },
                ),

                _buildMenuItem(
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
                  showArrow: false,
                  icon: PhosphorIconsLight.mapPinArea,
                  title: 'Area / Location',
                  subtitle: 'Kottakkal',
                  trailing: Text(
                    "Kottakkal",
                    style: GTextStyle.bodyBold.copyWith(color: kPrimaryColor),
                  ),
                ),
                _buildMenuItem(
                  imagePath: 'assets/images/logout.png',
                  title: 'Logout',
                  showArrow: true,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out',
            style: TextStyle(fontSize: screenWidth * 0.045),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout action
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.red,
                ),
              ),
            ),
          ],
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
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),

        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: onTap != null ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          // alignment: Alignment.topLeft,
          child: Row(
            children: [
              // Container(
              //   padding: EdgeInsets.all(10.w),
              //   decoration: BoxDecoration(
              //     color: kPrimaryColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(12.r),
              //   ),
              //   child:
              if (imagePath != null)
                Image.asset(
                  imagePath,
                  width: 22.w,
                  height: 27.h,
                  color:
                      title == 'Logout' ? Colors.red.shade200 : kPrimaryColor,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          icon != null
                              ? Icon(icon, size: 24.sp, color: kPrimaryColor)
                              : const SizedBox.shrink(),
                )
              else if (icon != null)
                PhosphorIcon(
                  icon,
                  size: size ?? 22.sp,
                  color:
                      title == "Logout" ? Colors.red.shade200 : kPrimaryColor,
                ),

              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GTextStyle.bodyBold.copyWith(
                        fontSize: 13.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: GTextStyle.bodyLight.copyWith(
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
              if (showArrow && trailing == null)
                Icon(Icons.chevron_right, color: kPrimaryColor, size: 20.sp),
            ],
          ),
        ),
      ),
    ),
  );
}

// Widget _buildDivider() {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 20.w),
//     child: Divider(height: 1.h, thickness: 1, color: Colors.grey.shade300),
//   );
// }
