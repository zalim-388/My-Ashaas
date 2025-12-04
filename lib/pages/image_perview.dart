import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImagePerview extends StatefulWidget {
  final String imagePath;
  const ImagePerview({super.key, required this.imagePath});

  @override
  State<ImagePerview> createState() => _ImagePerviewState();
}

class _ImagePerviewState extends State<ImagePerview> {
  late File imageFile;
  bool processing = false;
  int rotationDegrees = 0;

  @override
  void initState() {
    super.initState();
    imageFile = File(widget.imagePath);
  }

  Future<void> cropimage() async {
    if (processing || !mounted) {
      setState(() {
        processing = true;
      });
    }

    try {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 90,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Edit image",
            toolbarWidgetColor: white,
            navBarLight: true,
            statusBarColor: white,
            toolbarColor: kBlackPrimary,
            activeControlsWidgetColor: kBlackPrimary,
            backgroundColor: kBlackPrimary,
            dimmedLayerColor: kBlackPrimary,
            cropStyle: CropStyle.circle,
            hideBottomControls: false,
            lockAspectRatio: false,
            showCropGrid: true,
            cropGridColor: Colors.white54,
            cropFrameColor: kPrimaryColor,
            cropFrameStrokeWidth: 2,
            cropGridStrokeWidth: 1,
            initAspectRatio: CropAspectRatioPreset.square,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
            rotateButtonsHidden: false,
            hidesNavigationBar: false,
            minimumAspectRatio: 1.0,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );
      if (!mounted) return;
      if (cropped != null) {
        setState(() {
          imageFile = File(cropped.path);
          processing = false;
        });
      } else {
        setState(() {
          processing = false;
        });
      }
    } catch (e) {
      debugPrint("Error cropping image $e");
      if (mounted) {
        setState(() {
          processing = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Faild to crop image. please try again"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (processing) return false;
        return true;
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,

        appBar: AppBar(
          backgroundColor: kBlackPrimary,
          scrolledUnderElevation: 0,
          elevation: 0,
          leading: IconButton(
            onPressed:
                processing
                    ? null
                    : () {
                      Navigator.pop(context);
                    },
            icon: Icon(PhosphorIconsLight.x, color: white, size: 22.spMin),
          ),
          title: Text(
            "Perview",
            style: GTextStyle.heading2Medium.copyWith(color: white),
          ),
          actions: [
            IconButton(
              onPressed: processing ? null : cropimage,

              icon: Icon(
                PhosphorIconsLight.pencil,
                color: white,
                size: 22.spMin,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: kBlackPrimary,
                child: Center(
                  child:
                      processing
                          ? Column(
                            children: [
                              CircularProgressIndicator(color: kPrimaryColor),
                              SizedBox(height: 16.h),
                              Text(
                                "Procesing",
                                style: GTextStyle.body.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          )
                          : InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20.w),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image,
                                      size: 64.spMin,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "Unable to load image",
                                      style: GTextStyle.body.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                ),
              ),
            ),

            Container(
              color: kBlackPrimary,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            processing
                                ? null
                                : () {
                                  Navigator.pop(context);
                                },
                        child: Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: Colors.grey, width: 1.w),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsLight.x,
                                color: Colors.grey,
                                size: 20.spMin,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Cancel",
                                style: GTextStyle.button.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            processing
                                ? null
                                : () {
                                  Navigator.pop(context, imageFile);
                                },
                        child: Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            gradient:
                                processing
                                    ? null
                                    : LinearGradient(
                                      colors: [
                                        kBottomNavBarSelected.withOpacity(0.65),
                                        kBottomNavBarSelected,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomCenter,
                                    ),
                            border: Border.all(color: Colors.grey, width: 1.w),
                            color: processing ? Colors.grey : null,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          alignment: Alignment.center,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsLight.check,
                                color: Colors.grey,
                                size: 20.spMin,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Done",
                                style: GTextStyle.button.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
