import 'dart:convert';
import 'package:agent_porta/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'forget_pasword_page(1).dart';
import 'home_page.dart';
import '../layout_page.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import '../widgets/custom_listTile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int? selectedTile;
  bool _isPasswordVisible = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        selectedTile = _emailFocusNode.hasFocus ? 0 : null;
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
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("LOGIN SUCCESS DATA:");
        print(data); // prints full response

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login successful')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LayoutPage()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        print("LOGIN ERROR DATA:");
        print(errorData); // prints full error response

        String errorMessage =
            errorData['message'] ?? 'Login failed. Try again.';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      print("EXCEPTION OCCURRED:");
      print(e); // print error in console

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: kBackgroundColor,

        title: Text("Set Password", style: GTextStyle.heading1Bold),

        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),

              CircleAvatar(
                child: Icon(Icons.person, size: 10),

                backgroundColor: Colors.blueGrey,
                radius: 40.r,
              ),
              SizedBox(height: 30.h),

              CustomListTile(
                title: 'User name',
                hintText: 'Enter UserName',
                controller: emailController,
                focusNode: _emailFocusNode,

                showBorder: true,
                onTap: () {
                  _emailFocusNode.requestFocus();
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
                  // Navigator.pushReplacement(
                  //   //   context,
                  //   //   DialogRoute(
                  //   //     context: context,
                  //   //     builder: (context) => (),
                  //   //   ),
                  //   // );
                  // );
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

void _showGreetingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 8,
        child: Container(),
      );
    },
  );
}
