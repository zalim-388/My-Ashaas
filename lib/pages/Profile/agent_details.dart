import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:my_ashaas/widgets/ImagePiker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

class AgentDetails extends StatefulWidget {
  final String? image;
  const AgentDetails({super.key, this.image});

  @override
  State<AgentDetails> createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  File? _profileimage;

  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    //MARK:- Appbar
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: PreferredSize(
                preferredSize: Size.fromHeight( isLandscape?48.h: 56.h),
        child: buildAppbar(
          leadingColor: white,
          appbarColor: Colors.transparent,
          onPressedLeading: () {
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
                //    color: kprimaryGreen,
                gradient: LinearGradient(
                  colors: [kPrimaryColor.withOpacity(.7), kPrimaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                          color: kTextPrimary,
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
                          color: kBlackPrimary.withOpacity(0.1),
                        ),
                        child: Text(
                          'Youmail@gmail.com',
                          style: GTextStyle.bodyMedium.copyWith(
                            color: kTextPrimary,
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
                            data: '0123456789',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.home,
                            heading: 'Address',
                            data:
                                '...................... , ....... , ..... , ... , kerala , india  \nPOST : ....  \nPIN : 999999',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.id_badge,
                            heading: 'Pan card',
                            data: 'HS....',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.portrait,
                            heading: 'Aadhar card',
                            data: '0123456789',
                          ),

                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.phone_call,
                            heading: 'Alternate Mobile',
                            data: '0123456789',
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: UIcons.regularRounded.users,
                            heading: 'Nominee',
                            data: '0123456789',
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
              child: GestureDetector(
                onTap: () async {
                  final result = await pikeprofileimage(
                    context: context,
                    mounted: mounted,
                    picker: _picker,
                  );

                  if (result != null && mounted) {
                    setState(() {
                      _profileimage = result;
                    });
                  }
                },

                child: Container(
                  height: isLandscape ? 120 : 110.h,
                  width: isLandscape ? 120 : 110.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
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
                  child:
                      _profileimage != null
                          ? ClipOval(
                            child: Image.file(
                              _profileimage!,
                              fit: BoxFit.cover,
                            ),
                          )
                          : Icon(
                            Icons.person,
                            size: 30.spMin,
                            color: Colors.grey,
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
      color: kContainerBgColor,
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

                child: Icon(icon, color: kIconColor, size: 24.spMin),
              ),

              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: GTextStyle.bodyBold.copyWith(color: kTextPrimary),
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
          backgroundColor: kBlackPrimary,
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
