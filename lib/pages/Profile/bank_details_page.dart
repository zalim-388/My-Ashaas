import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';


class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  final String accountNumber = "1234567890123456";
  final String ifscCode = "SBIN0001234";
  final String userName = "John Doe";
  final String branchCode = "001234";
  final String bankName = "State Bank of India";

  void _copyToClipboard(BuildContext context, String fieldName) {
    if (fieldName.isEmpty) return;

    Clipboard.setData(ClipboardData(text: fieldName)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$fieldName Copied",
            textAlign: TextAlign.center,
            style: GTextStyle.captionMedium(color: Colors.white),
          ),
          duration: Duration(milliseconds: 2001),
          backgroundColor: kBlackPrimary,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left: 120.w, right: 120.w, bottom: 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          elevation: 0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //   colors: [Color(0xDE000000), Colors.black],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'Bank Details',
              style: GTextStyle.heading1Medium.copyWith(color: kBlackPrimary),
            ),
            leading: IconButton(
              icon: Icon(
                UIcons.solidRounded.angle_left,
                size: 18.spMin,
                color: kBlackPrimary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 35.h),
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //    colors: [kBlackPrimary, black.withOpacity(.7)],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
              ),
              child: Column(
                children: [
                  Icon(
                    PhosphorIconsLight.bank,
                    size: 48.spMin,
                    color: kBlackPrimary,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Your Bank Information',
                    style: GTextStyle.bodyMedium.copyWith(color: kBlackPrimary),
                  ),
                  SizedBox(height: isLandscape ? 2.h : 4.h),
                  Text(
                    'Secure banking details',
                    style: GTextStyle.bodyLight.copyWith(
                      color: kBlackPrimary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 10.h),
            _buildDivider(),
            SizedBox(height: 10.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildDetailField(
                    context: context,
                    icon: PhosphorIconsLight.user,
                    title: 'Account Holder Name',
                    value: userName,
                    fieldName: 'Account Holder Name',
                  ),

                  _buildDetailField(
                    context: context,
                    icon: PhosphorIconsLight.creditCard,
                    title: 'Account Number',
                    value: accountNumber,
                    fieldName: 'Account Number',
                    isSensitive: true,
                  ),

                  _buildDetailField(
                    context: context,
                    icon: PhosphorIconsLight.barcode,
                    title: 'IFSC Code',
                    value: ifscCode,
                    fieldName: 'IFSC Code',
                  ),

                  _buildDetailField(
                    context: context,
                    icon: PhosphorIconsLight.bank,
                    title: 'Bank Name',
                    value: bankName,
                    fieldName: 'Bank Name',
                  ),
                  _buildDetailField(
                    context: context,
                    icon: PhosphorIconsLight.mapPin,
                    title: 'Branch Code',
                    value: branchCode,
                    fieldName: 'Branch Code',
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),

            // Note section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isLandscape ? 10.w : 16.w),
              margin: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
              decoration: BoxDecoration(
                color: kContainerBgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIconsLight.info,
                    size: 20.spMin,
                    color: kIconColor,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Keep your bank details secure and do not share them with unauthorized persons. Tap on any field to copy the information.',
                      style: GTextStyle.bodyLight.copyWith(color: kTextPrimary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailField({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required String fieldName,
    bool isSensitive = false,
  }) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Card(
      shadowColor: Colors.grey.shade100,
      color: kContainerBgColor,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: InkWell(
        onLongPress: () {
          _copyToClipboard(context, fieldName);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 10.w : 16.w,
            vertical: 14.h,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: kPrimaryColor.withOpacity(0.1),
                ),

                child: Icon(icon, color: kBlackPrimary, size: 22.spMin),
              ),

              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldName,
                      style: GTextStyle.bodyBold.copyWith(color: kBlackPrimary),
                    ),
                    SizedBox(height: 2.h),

                    Text(
                      isSensitive ? _maskAccountNumber(value) : value,
                      style: GTextStyle.bodySmall.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  _copyToClipboard(context, fieldName);
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

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    String masked = '*' * (accountNumber.length - 4);
    return masked + accountNumber.substring(accountNumber.length - 4);
  }
}

Widget _buildDivider() {
  return Center(
    child: Container(
      width: 70.w,
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            kBlackPrimary.withOpacity(0.9),
            Colors.transparent,
          ],
        ),
      ),
    ),
  );
}
