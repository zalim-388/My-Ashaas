
import 'dart:convert';

import 'package:agent_porta/pages/set_pasaword.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/styles/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ForgotChnagePage extends StatefulWidget {
  final String otp;
  const ForgotChnagePage({Key? key,  required this.otp}) : super(key: key);

  @override
  _ForgotChnagePageState createState() => _ForgotChnagePageState();
}

class _ForgotChnagePageState extends State<ForgotChnagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final String phoneNumber = _phoneController.text;
      final String password = _passwordController.text;

      final response = await http.post(
        Uri.parse('https://api.malabarbank.in/api/verifyOtpAndUpdatePassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phonenumber': phoneNumber,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => setpassword()),
        );
      } else {
        // Handle error response
        print('Failed to update password.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter New Password',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enter the email address associated with your account.',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'We will email you a verification code to check your authenticity.',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 12,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: _phoneController,
                                  style: GTextStyle.bodyBold.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.black,
                                  decoration: ThemeHelper().textInputDecoration(
                                    lableText: "Mobile Number",
                                    //hintText: "Enter your mobile number",
                                    icon: Icon(Icons.phone_android_rounded, size: 17),
                                  ).copyWith(
                                    errorStyle: GTextStyle.bodyBold.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Mobile number can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: _passwordController,
                                  style: GTextStyle.bodyBold.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: ThemeHelper().textInputDecoration(
                                    lableText: "New Password",
                                    //hintText: "Enter new password",
                                    icon: Icon(Icons.lock, size: 17),
                                  ).copyWith(
                                    errorStyle: GTextStyle.bodyBold.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    }
                                    return null;
                                  },

                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  style: GTextStyle.bodyBold.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: ThemeHelper().textInputDecoration(
                                    lableText: "Confirm Password",
                                    //hintText: "Re-Enter new password",
                                    icon: Icon(Icons.password_sharp, size: 17),
                                  ).copyWith(
                                    errorStyle: GTextStyle.bodyBold.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    if (val != _passwordController.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context,color1: '#5E8A78',color2: '#5E8A78'),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> setpassword()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "done".toUpperCase(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                            ],
                          ),
                        ),
                      ],
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