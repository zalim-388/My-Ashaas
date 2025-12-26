import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_ashaas/pages/Congratulation.dart';
import 'package:my_ashaas/pages/image_perview.dart';
import 'package:my_ashaas/pages/verify_screen.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:uicons/uicons.dart';
import 'Forget password/forget_pasword.dart';

import 'package:my_ashaas/styles/constants.dart';
import '../styles/style.dart';

class Setpassword extends StatefulWidget {
  const Setpassword({super.key});

  @override
  State<Setpassword> createState() => _LoginPageState();
}

class _LoginPageState extends State<Setpassword> {
  int? selectedTile;
  File? _profileimage;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController usenameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pikeprofileimage() async {
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
              SizedBox(height: 12.h,),
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
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(sheetContext, 'camera');
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: kPrimaryColor.withOpacity(.1),
                          child: Icon(
                            Ionicons.camera,
                            size: 25.spMin,
                            color: kIconColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text('Camera', style: GTextStyle.bodySmall.copyWith()),
                      ],
                    ),
                  ),
                  // Gallery option
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(sheetContext, 'gallery');
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: kBlackPrimary.withOpacity(0.1),
                          child: Icon(
                            Ionicons.images,
                            size: 25.spMin,
                            color: kIconColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Gallery',
                          style: GTextStyle.bodySmall.copyWith(
                            color: kTextPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (source == null || !mounted) return;

    await Future.delayed(Duration(milliseconds: 100));

    try {
      String? imagePath;
      if (source == 'camera') {
        final XFile? pickedFile = await _picker.pickImage(
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
      if (imagePath == null || !mounted) return;
      final File? editedImage = await Navigator.push<File>(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePerview(imagePath: imagePath!),
        ),
      );

      if (editedImage != null && mounted) {
        setState(() {
          _profileimage = editedImage;
        });
      }
    } catch (e) {
      debugPrint("Error Picking img$e");
    }
  }

  @override
  void initState() {
    super.initState();

    _usernameFocusNode.addListener(() {
      setState(() {
        selectedTile = _usernameFocusNode.hasFocus ? 0 : null;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        selectedTile = _passwordFocusNode.hasFocus ? 1 : null;
      });
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    usenameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      //MARK:- AppBar
      appBar:
          isLandscape
              ? null
              : AppBar(
                backgroundColor: kBackgroundColor,
                scrolledUnderElevation: 0,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyScreen()),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  icon: Icon(
                    UIcons.solidRounded.angle_left,
                    size: 18.spMin,
                    color: kArrowBackColor,
                  ),
                ),
                title: Text(
                  "Set Password",
                  style: GTextStyle.heading2Medium.copyWith(),
                ),
                titleSpacing: 10.w,
                centerTitle: false,
              ),
      body:
          isLandscape
              ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: kBackgroundColor,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyScreen(),
                            ),
                          );
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kPrimaryColor,
                          size: 20.spMin,
                        ),
                      ),
                      title: Text(
                        "Set Password",
                        style: GTextStyle.heading2Bold.copyWith(),
                      ),
                      titleSpacing: 10.w,
                      centerTitle: false,
                    ),
                  ];
                },
                body: _mainBody(isLandscape),
              )
              : _mainBody(isLandscape),
    );
  }

  Widget _mainBody(bool isLandscape) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isLandscape ? 30.h : 130.h),
              //MARK:- Profile ........
              GestureDetector(
                onTap: _pikeprofileimage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: isLandscape ? 110.h : 90.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kTextFieldBorder,
                          width: isLandscape ? 3.w : 2.w,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: isLandscape ? 55.r : 45.r,
                        backgroundImage:
                            _profileimage != null
                                ? FileImage(_profileimage!)
                                : null,
                        child:
                            _profileimage == null
                                ? Icon(Icons.camera_alt, size: 40, color: grey)
                                : null,
                      ),
                    ),
                    if (_profileimage == null)
                      Positioned(
                        bottom: isLandscape ? 5 : 0,
                        top: isLandscape ? 5 : 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: isLandscape ? 18.r : 15.r,
                          child: Icon(
                            Icons.camera_alt,
                            size: isLandscape ? 25 : 16.sp,
                            color: grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              buildADDField(
                context: context,
                label: "User name",
                hintText: "Enter UserName",
                Controller: usenameController,
                showBorderside: true,
                keybordType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
              ),

              buildADDField(
                label: "Password",
                hintText: "Enter password",
                Controller: passwordController,
                context: context,
                keybordType: TextInputType.visiblePassword,
                showBorderside: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Password';
                  }
                  if (value.trim().length < 4) {
                    return 'Password must be at least 4 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (BuildContext context, _, _) {
                        return const Congratulation();
                      },
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 45.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kBottomNavBarSelected.withOpacity(0.610),
                        kBottomNavBarSelected,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Next',
                    style: GTextStyle.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 3.h,
                  ),
                ),
                child: Text(
                  'Forgot Password ?',
                  style: GTextStyle.bodyBold.copyWith(color: kTextOnPrimary),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
