import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RequestMoneyDialog {
  static void show(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            backgroundColor: Colors.transparent,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(16.r),
            // ),
            elevation: 0,

            child: Container(
              width: isLandscape ? 500 : double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: kBackgroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isLandscape ? 12.w : 20.w),
                      decoration: BoxDecoration(
                       
                        gradient: LinearGradient(
                          colors: [
                             kBlackPrimary.withOpacity(.7),
                           kBlackPrimary
                           
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/save-money.png',
                            width: isLandscape ? 50 : 40.w,
                            height: isLandscape ? 50 : 40.h,
                            color: Colors.white,
                            errorBuilder:
                                (context, error, stackTrace) => Icon(
                                  PhosphorIconsLight.money,
                                  size: 40.sp,
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(height: 12.w),
                          Text(
                            'Request Money',
                            style: GTextStyle.heading2Bold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Send request to Porta',
                            style: GTextStyle.bodyMedium.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(isLandscape ? 12.w : 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildADDField(
                            showBorderside: true,
                            label: "Enter Amount",
                            hintText: "Enter Amount",
                            Controller: amountController,
                            context: context,
                            keybordType: TextInputType.number,
                            perfixText: "₹ ",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Quick Amount Buttons
                          Text(
                            'Quick Select',
                            style: GTextStyle.bodyLight.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          Row(
                            children: [
                              _buildQuickButton(
                                context,
                                amountController,
                                ' 500',
                              ),
                              SizedBox(width: 8.w),
                              _buildQuickButton(
                                context,
                                amountController,
                                ' 1000',
                              ),
                              SizedBox(width: 8.w),
                              _buildQuickButton(
                                context,
                                amountController,
                                ' 2000',
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.black87
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.h,
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: GTextStyle.bodyLight.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: isLandscape ? 6.w : 12.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _sendRequest(context, amountController);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kBottomNavBarSelected,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.r,
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'Send',
                                    style: GTextStyle.bodyBold.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildQuickButton(
    BuildContext context,
    TextEditingController controller,
    String amount,
  ) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.text = amount;
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isLandscape ? 6.h : 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: kBlackPrimary),
            borderRadius: BorderRadius.circular(30.r),
            color: kPrimaryColor.withOpacity(0.05),
          ),
          child: Text(
            '₹$amount',
            textAlign: TextAlign.center,
            style: GTextStyle.bodyLight.copyWith(color: kTextPrimary),
          ),
        ),
      ),
    );
  }

  static void _sendRequest(
    BuildContext context,
    TextEditingController amountController,
  ) {
    String amount = amountController.text.trim();

    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an amount'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pop();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Money request of ₹$amount sent to Porta successfully!',
        style: GTextStyle.body.copyWith(
          color:Colors.white
        ),
        ),
        backgroundColor: kBlackPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// void _showRequestMoneyDialog(BuildContext context) {
//   final TextEditingController amountController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//         child: AlertDialog(
//           backgroundColor: Colors.white38,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/save-money.png',
//                 width: 24,
//                 height: 24,
//                 color: kPrimaryColor,
//                 errorBuilder:
//                     (context, error, stackTrace) => Icon(
//                       PhosphorIconsLight.money,
//                       size: 24,
//                       color: kPrimaryColor,
//                     ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'Request Money',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Enter the amount you want to request from Porta:',
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   prefixText: '₹ ',
//                   prefixStyle: TextStyle(
//                     color: kPrimaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   hintText: 'Enter amount',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: kPrimaryColor),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String amount = amountController.text.trim();
//                 if (amount.isNotEmpty) {
//                   // Handle the send request logic here
//                   Navigator.of(context).pop();

//                   // Show success message
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Money request of ₹$amount sent to Porta'),
//                       backgroundColor: kPrimaryColor,
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   );
//                 } else {
//                   // Show error message
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please enter an amount'),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kPrimaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 12,
//                 ),
//               ),
//               child: const Text(
//                 'Send',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
