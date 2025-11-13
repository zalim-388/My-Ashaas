import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

class AgentDetails extends StatelessWidget {
  final String? image;
  const AgentDetails({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 18.spMin,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0.h,
            left: 0.w,
            right: 0.w,
            height: 220.h,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(.65)],
                ),
              ),
            ),
          ),

          Positioned.fill(
            top: 190.h,
            child: Container(
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 30.h),
                  child: Column(
                    children: [
                      Text(
                        'Your Name',
                        style: GTextStyle.heading1Bold.copyWith(
                          // fontSize: isLandscape ? 12.sp : 20.sp,
                          // fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: isLandscape ? 4.h : 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.grey.shade300,
                        ),
                        child: Text(
                          'Youmail@gmail.com',
                          style: GTextStyle.bodyMedium.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      // Menu items
                      Column(
                        children: [
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.mobile_button,
                            heading: 'Mobile number',
                            data: '9544957003',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.home,
                            heading: 'Address',
                            data:
                                'Kattukulath house , kelamkulam , chettiyamKinar , malappuram , kerala , india  \nPOST : klari  \nPIN : 676501',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.id_badge,
                            heading: 'Pan card',
                            data: 'HSDFB5325J',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.portrait,
                            heading: 'Aadhar card',
                            data: '123456789012',
                          ),

                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.phone_call,
                            heading: 'Alternate Mobile',
                            data: '9865421752',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.users,
                            heading: 'Nominee',
                            data: '9865421752',
                          ),

                          SizedBox(height: 50.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: isLandscape ? 100.h : 170.h - (110.h / 2),
            left: 0,
            right: 0,

            child: Center(
              child: Container(
                height: isLandscape ? 120 : 110.h,
                width: isLandscape ? 120 : 110.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20.r,
                      spreadRadius: 2.r,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 30.spMin,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String heading,
    String? data,
  }) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Card(
      color: Colors.grey.shade100,
      shadowColor: Colors.grey.shade100,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onLongPress: () {
          _copyToClipboard(context, heading);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 10.w : 16.w,
            vertical: 14.h,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: kPrimaryColor.withOpacity(0.1),
                ),

                child: Icon(icon, color: kprimaryGreen, size: 24.spMin),
              ),

              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: GTextStyle.bodyBold.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    if (data != null && data.isNotEmpty)
                      Text(
                        data,
                        style: GTextStyle.bodySmall.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  _copyToClipboard(context, heading);
                },

                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Icon(
                    PhosphorIconsLight.copy,
                    size: 18.spMin,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    if (text.isEmpty) return;

    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$text Copied",
            textAlign: TextAlign.center,
            style: GTextStyle.bodySmall.copyWith(color: Colors.white),
          ),
          duration: Duration(milliseconds: 2001),
          backgroundColor: kprimaryGreen,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left: 140.w, right: 120.w, bottom: 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          elevation: 0,
        ),
      );
    });
  }
}
