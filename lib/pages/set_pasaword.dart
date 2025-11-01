import 'dart:io';
import 'package:agent_porta/pages/Congratulation.dart';
import 'package:agent_porta/pages/verify_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forget_pasword_page(1).dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import '../widgets/custom_listTile.dart';

class setpassword extends StatefulWidget {
  const setpassword({super.key});

  @override
  State<setpassword> createState() => _LoginPageState();
}

class _LoginPageState extends State<setpassword> {
  int? selectedTile;
  bool _isPasswordVisible = false;
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
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        backgroundColor: kBackgroundColor,

        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VerifyScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: black),
        ),
        title: Text("Set Password", style: GTextStyle.heading1Bold),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 0.h),

              GestureDetector(
                onTap: _pikeprofileimage,
                child: CircleAvatar(
                  child:
                      _profileimage != null
                          ? ClipOval(
                            child: Image.file(
                              _profileimage!,
                              width: 90.r,
                              height: 90.r,
                              fit: BoxFit.cover,
                            ),
                          )
                          : Icon(Icons.camera_alt, size: 40, color: grey),
                  backgroundColor: Colors.grey[300],
                  radius: 45.r,
                ),
              ),
              SizedBox(height: 30.h),

              CustomListTile(
                title: 'User name',
                hintText: 'Enter UserName',
                controller: usenameController,
                focusNode: _usernameFocusNode,

                showBorder: true,
                onTap: () {
                  _usernameFocusNode.requestFocus();
                },

                keyboardType: TextInputType.name,

                tileColor: Colors.grey[200],
              ),
              SizedBox(height: 15.h),
              CustomListTile(
                title: 'password',
                hintText: 'Enter password',
                controller: passwordController,
                focusNode: _passwordFocusNode,
                obscureText: !_isPasswordVisible,

                onTap: () {
                  _passwordFocusNode.requestFocus();
                },

                keyboardType: TextInputType.visiblePassword,
                icon:
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                onPressedIcon: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              SizedBox(height: 50.h),
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
                      fontSize: 18.sp,
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
            ],
          ),
        ),
      ),
    );
  }
}
