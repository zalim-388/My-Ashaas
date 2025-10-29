import '../styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/styles/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'forget_password_verification.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendPasswordResetRequest() async {
    final email = _emailController.text;
    final url = Uri.parse('https://api.malabarbank.in/api/requestpasswordupdate');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
         final responseData = json.decode(response.body);
      final otp = responseData['otp'];
      print('machu: $otp'); // Print the OTP to the console

        // Navigate to the verification page if the email is sent successfully
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage(otp:otp)),
        );
      } else {
        // Show an error message if something went wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send reset email. Please try again.')),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                   // margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                'Forgot Password?',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enter the email address associated with your account.',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'We will email you a verification code to check your authenticity.',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 13,
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
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: GoogleFonts.varela(fontSize: 14, fontWeight: FontWeight.w600),
                                  cursorColor: kPrimaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: ThemeHelper()
                                      .textInputDecoration(
                                        lableText: "Email",
                                        //hintText: "Enter your email",
                                        icon: Icon(Icons.person, size: 21),
                                      )
                                      .copyWith(
                                        errorStyle: GTextStyle.bodyBold.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Email can't be empty";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "Enter a valid email address";
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
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "Send".toUpperCase(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    //   _sendPasswordResetRequest();
                                    // }
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage(otp:'2323')),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Remember your password? ",
                                        style: GTextStyle.bodyBold.copyWith(fontSize: 14,fontWeight: FontWeight.w400)),
                                    TextSpan(
                                      text: 'Login',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginPage()),
                                          );
                                        },
                                      style: GTextStyle.bodyBold.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
