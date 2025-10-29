import 'package:agent_porta/styles/theme_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';


import '../styles/constants.dart';
import 'forget_password_change_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordVerificationPage(otp: '2323'),
    );
  }
}

class ForgotPasswordVerificationPage extends StatefulWidget {
  final String otp;

  const ForgotPasswordVerificationPage({Key? key,  required this.otp}) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() => _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;
  String _enteredOtp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Center(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      //margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.fromLTRB(25, 0, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Verification',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Enter the verification code we just sent you on your email address.',
                                  style: GoogleFonts.varela(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(
                                    textSelectionTheme: const TextSelectionThemeData(
                                      cursorColor: Colors.black54,
                                    ),
                                  ),
                                  child: OTPTextField(
                                    length: 6,
                                    width: 300,
                                    fieldWidth: 35,
                                    style: GoogleFonts.roboto(
                                        fontSize: 18, color: Colors.black),
                                    otpFieldStyle: OtpFieldStyle(
                                      focusBorderColor: Colors.black,
                                    ),
                                    textFieldAlignment: MainAxisAlignment.spaceAround,
                                    fieldStyle: FieldStyle.box,
                                    onCompleted: (pin) {
                                      setState(() {
                                        _enteredOtp = pin;
                                        _pinSuccess = _enteredOtp == widget.otp;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 60.0),
                                // Center(
                                //   child: Text.rich(
                                //     TextSpan(
                                //       children: [
                                //         TextSpan(
                                //           text: "If you didn't receive a code! ",
                                //           style: GoogleFonts.varela(
                                //             color: Colors.black38,
                                //           ),
                                //         ),
                                //         TextSpan(
                                //           text: 'Resend',
                                //           recognizer: TapGestureRecognizer()
                                //             ..onTap = () {
                                //               showDialog(
                                //                 context: context,
                                //                 builder: (BuildContext context) {
                                //                   return ThemeHelper().alartDialog(
                                //                       "Successful",
                                //                       "Verification code resend successful.",
                                //                       context);
                                //                 },
                                //               );
                                //             },
                                //           style: GoogleFonts.varela(
                                //               fontWeight: FontWeight.bold,
                                //               color: kPrimaryColor1),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                //const SizedBox(height: 40.0),
                                Container(
                                  decoration: _pinSuccess
                                      ? ThemeHelper().buttonBoxDecoration(context,color1: '#5E8A78',color2: '#5E8A78')
                                      : ThemeHelper().buttonBoxDecoration(
                                          context, color1: "#AAAAAA",color2: "#757575"),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    // onPressed: _pinSuccess
                                    //     ? () {
                                    //         Navigator.of(context).pushAndRemoveUntil(
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     ForgotChnagePage( otp: widget.otp!,)),
                                    //             (Route<dynamic> route) => false);
                                    //       }
                                    //     : null,
                                    onPressed: (){
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotChnagePage( otp: widget.otp!,)),
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "Verify".toUpperCase(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
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
