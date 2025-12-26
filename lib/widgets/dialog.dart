import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/buttons.dart';
import 'package:my_ashaas/widgets/snackBar.dart';

void showConfirmDialog({
  int? index,
  required BuildContext context,
  required String? tilte,
  required String? subtitle,
  required VoidCallback onTap,
  String? snackbarType,
  String? snackbarMsg,
  required String? actionlabel1,
  required String? actionlabel2,

  Color? activecolor,
}) {
  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
          contentPadding: EdgeInsets.all(20.w),
          backgroundColor: kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tilte ?? "Are you sure?",
                textAlign: TextAlign.center,
                style: GTextStyle.heading2Bold.copyWith(color: kTextPrimary),
              ),
              SizedBox(height: 10.h),
              Text(
                subtitle ??
                    "Do you want to proceed with this action?", //      "Are you sure you want to delete?",
                style: GTextStyle.body.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: buildButtions(
                      radius: BorderRadius.circular(12.r),
                      gradientColor1: Colors.white,
                      gradientColor2: Colors.white,
                      showborder: true,
                      borderColor: Colors.grey.shade300,
                      context: context,
                      label: actionlabel1 ?? 'Cancel',
                      textColor: kBlackPrimary,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: buildButtions(
                      radius: BorderRadius.circular(12.r),
                      usesolidColor: true,
                      solidColor: activecolor ?? red.withOpacity(.7),
                      context: context,
                      label: actionlabel2 ?? "Delete",
                      onTap: () {
                        Navigator.pop(ctx);
                        onTap();
                        Navigator.pop(context);
                        showSnackBar(
                          type: snackbarType ?? 'success',
                          context: context,
                          message: snackbarMsg ?? "",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
  );
}
