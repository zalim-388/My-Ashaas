import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:my_ashaas/widgets/snackBar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      buildShortSnackbar(context, kprimaryGreen, Message: "$fieldName Copied");
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      //MARK:- Appbar
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isLandscape ? 48.h : 56.h),
        child: buildAppbar(
          leadingColor: white,
          appbarColor: kprimaryGreen,
          onPressedLeading: () {
            Navigator.pop(context);
          },
          centerTitle: true,
          titleText: 'Bank Details',
          titleColor: white,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 35.h),
              decoration: BoxDecoration(color: kprimaryGreen),
              child: Column(
                children: [
                  Icon(PhosphorIconsLight.bank, size: 48.spMin, color: white),
                  SizedBox(height: 12.h),
                  Text(
                    'Your Bank Information',
                    style: GTextStyle.bodyMedium.copyWith(
                      color: kTextOnPrimary,
                    ),
                  ),
                  SizedBox(height: isLandscape ? 2.h : 4.h),
                  Text(
                    'Secure banking details',
                    style: GTextStyle.bodyLight.copyWith(color: kTextOnPrimary),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10.h),
            // _buildDivider(),
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
        side: BorderSide(color: kTextFieldBorder.withOpacity(0.1)),
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
                    color: kIconColor,
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

// Widget _buildDivider() {
//   return Center(
//     child: Container(
//       width: 70.w,
//       height: 2,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.transparent,
//             kBlackPrimary.withOpacity(0.9),
//             Colors.transparent,
//           ],
//         ),
//       ),
//     ),
//   );
// }
