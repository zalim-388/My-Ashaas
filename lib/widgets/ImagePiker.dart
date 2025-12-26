import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ashaas/pages/image_perview.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<File?> pikeprofileimage({
  required BuildContext context,
  required bool mounted,
  required dynamic picker,
}) async {
  final String? source = await showModalBottomSheet(
    backgroundColor: kBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    context: context,
    builder: (BuildContext sheetContext) {
      return SizedBox(
        height: 150.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12.h),
            Text(
              'Profile photo',
              textAlign: TextAlign.center,
              style: GTextStyle.heading3,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Camera option
                _buildOption(
                  icon: PhosphorIconsLight.camera,
                  label: "Camera",
                  onTap: () {
                    Navigator.pop(sheetContext, 'camera');
                  },
                ),

                // Gallery option
                _buildOption(
                  icon: PhosphorIconsLight.image,
                  label: "Gallery",
                  onTap: () {
                    Navigator.pop(sheetContext, 'gallery');
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  if (source == null || !mounted) return null;

  await Future.delayed(Duration(milliseconds: 100));

  try {
    String? imagePath;
    if (source == 'camera') {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
      );
      imagePath = pickedFile?.path;
    } else if (source == 'gallery') {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      imagePath = result?.files.single.path;
    }
    if (imagePath == null || !mounted) return null;
    final File? editedImage = await Navigator.push<File>(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePerview(imagePath: imagePath!),
      ),
    );

 return editedImage;
    
  } catch (e) {
    debugPrint("Error Picking img$e");
  }
}

Widget _buildOption({
  required IconData icon,
  required String label,
  required VoidCallback? onTap,
}) {
  return InkWell(
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    hoverColor: Colors.transparent,
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: kBlackPrimary.withOpacity(0.1),
          child: Icon(icon, size: 25.spMin, color: kIconColor),
        ),
        SizedBox(height: 8.h),
        Text(label, style: GTextStyle.bodySmall.copyWith(color: kTextPrimary)),
      ],
    ),
  );
}
