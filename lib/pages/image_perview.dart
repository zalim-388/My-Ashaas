import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:image/image.dart' as img;

class ImagePerview extends StatefulWidget {
  final String imagePath;
  const ImagePerview({super.key, required this.imagePath});

  @override
  State<ImagePerview> createState() => _ImagePerviewState();
}

class _ImagePerviewState extends State<ImagePerview> {
  late File imageFile;

  final bool _uploading = false;

  @override
  void initState() {
    super.initState();
    imageFile = File(widget.imagePath);
  }

  void _uploadimageFile(File newFile) {
    if (mounted) {
      setState(() {
        imageFile = newFile;
      });
    }
  }

  Future<void> cropimage() async {
    try {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 90,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop",
            toolbarColor: kBlackPrimary,
            toolbarWidgetColor: white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            hideBottomControls: true,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),

          IOSUiSettings(
            title: "Crop",
            aspectRatioLockEnabled: false,
            resetButtonHidden: false,
            aspectRatioPickerButtonHidden: true,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );
      if (!mounted) return;

      if (cropped != null) {
        setState(() {
          _uploadimageFile(File(cropped.path));
        });
      }
    } catch (e) {
      debugPrint("Error cropping image $e");
      if (mounted) {
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

  Future<void> _rotationImg() async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      final img.Image? capturedImage = img.decodeImage(bytes);

      if (capturedImage != null) {
        final img.Image rotatedImage = img.copyRotate(capturedImage, angle: 90);
        final List<int> newBytes = img.encodeJpg(rotatedImage, quality: 100);

        final String tempth =
            '${imageFile.parent.path}/rotated_${DateTime.now().millisecondsSinceEpoch}.jpg';

        final File rotatedFile = await File(tempth).writeAsBytes(newBytes);

        PaintingBinding.instance.imageCache.clear();
        PaintingBinding.instance.imageCache.clearLiveImages();
        _uploadimageFile(rotatedFile);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _saveimg() {
    Navigator.pop(context, imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //MARK:- body
    return Scaffold(
      backgroundColor: kBlackPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: buildAppbar(
          appbarColor: kBlackPrimary,
          leadingColor: white,
          onPressedLeading: () {},
          titleText: "Perview",
          titleColor: white,
          action: [
            InkWell(
              onTap: _uploading ? null : _saveimg,
              child:
                  _uploading
                      ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: SvgPicture.asset(
                          "assets/loading/bouncing-ball.svg",
                          color: ksendiconColor,
                        ),
                      )
                      : Container(
                        padding: EdgeInsets.all(isLandscape ? 4.w : 8.w),
                        decoration: BoxDecoration(
                          color: ksendiconColor,
                          shape: BoxShape.circle,

                          boxShadow: [
                            BoxShadow(
                              color: grey.withOpacity(0.5),
                              blurRadius: 8.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          PhosphorIconsRegular.paperPlaneTilt,
                          size: 22.spMin,
                          color: kIconColor,
                        ),
                      ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: EdgeInsets.all(20.w),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
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
                            style: GTextStyle.body.copyWith(color: Colors.grey),
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
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTool(PhosphorIconsLight.crop, "Crop", cropimage),
                  _buildTool(Icons.rotate_right, "Rotate", _rotationImg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTool(IconData icon, String label, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: white, size: 28.spMin),
        SizedBox(height: 5.h),
        Text(label, style: GTextStyle.captionMedium.copyWith(color: white)),
      ],
    ),
  );
}
