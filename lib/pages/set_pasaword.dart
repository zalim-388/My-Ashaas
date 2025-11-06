import 'dart:io';
import 'package:agent_porta/pages/Congratulation.dart';
import 'package:agent_porta/pages/verify_screen.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forget_pasword_page(1).dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';

class setpassword extends StatefulWidget {
  const setpassword({super.key});

  @override
  State<setpassword> createState() => _LoginPageState();
}

class _LoginPageState extends State<setpassword> {
  int? selectedTile;
  // bool _isPasswordVisible = false;
  File? _profileimage;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController usenameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _pikeprofileimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _profileimage = File(result.files.single.path!);
      });
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
    _usernameFocusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar:
          isLandscape
              ? null
              : AppBar(
                backgroundColor: kBackgroundColor,

                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyScreen()),
                    );
                  },

                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  icon: Icon(Icons.arrow_back_ios, color: black),
                ),
                title: Text(
                  "Set Password",
                  style: GTextStyle.bodyBold.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                titleSpacing: 30.w,
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
                          color: black,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        "Set Password",
                        style: GTextStyle.bodyBold.copyWith(
                          fontSize: isLandscape ? 25 : 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      titleSpacing: 30.w,
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
              SizedBox(height: isLandscape ? 30.h : 80.h),

              GestureDetector(
                onTap: _pikeprofileimage,
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: isLandscape ? 55.r : 45.r,
                      backgroundImage:
                          _profileimage != null
                              ? FileImage(_profileimage!)
                              : null,
                    ),
                    if (_profileimage == null)
                      Icon(Icons.camera_alt, size: 40, color: grey),

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
                label: "password",
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
              SizedBox(height: 48.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Congratulation()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Next',
                    style: GTextStyle.bodyBold.copyWith(
                      fontSize: isLandscape ? 11.sp : 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
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
                  style: GTextStyle.bodyMedium.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
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
