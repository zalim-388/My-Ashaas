import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

class AgentDetails extends StatelessWidget {
  final String? image;
  const AgentDetails({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 15,
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
            top: 0,
            left: 0,
            right: 0,
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
            top: 170.h,
            child: Container(
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 30.h),
                  child: Column(
                    children: [
                      Text(
                        'name',
                        style: GTextStyle.bodyBold.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          'Youmail@gmail.com',
                          style: GTextStyle.bodyMedium.copyWith(
                            fontSize: 15.sp,
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
                            icon: UIcons.regularRounded.address_book,
                            heading: 'Address',
                            data:
                                'Kattukulath house , kelamkulam , chettiyamKinar , malappuram , kerala , india  \nPOST : klari  \nPIN : 676501',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.credit_card,
                            heading: 'Pan card',
                            data: 'HSDFB5325J',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: Ionicons.id_card_outline,
                            heading: 'Aadhar card',
                            data: '123456789012',
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
            top: 170.h - (110.h / 2),
            left: 0,
            right: 0,

            child: Center(
              child: Container(
                height: 110.h,
                width: 110.h,
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
                        child: Icon(Icons.person, size: 30, color: Colors.grey),
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
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: kPrimaryColor.withOpacity(0.1),
              ),

              child: Icon(icon, color: kPrimaryColor, size: 22.sp),
            ),

            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: GTextStyle.bodyBold.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  if (data != null && data.isNotEmpty)
                    Text(
                      data,
                      style: TextStyle(
                        fontSize: 14.h,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  PhosphorIconsLight.copy,
                  size: 18.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
