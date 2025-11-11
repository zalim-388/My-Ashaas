import 'package:agent_porta/pages/Congratulation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterNewPass extends StatefulWidget {
  final String otp;
  const EnterNewPass({Key? key, required this.otp}) : super(key: key);

  @override
  _EnterNewPassState createState() => _EnterNewPassState();
}

class _EnterNewPassState extends State<EnterNewPass> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Future<void> _submit() async {
  //   if (_formKey.currentState!.validate()) {
  //     final String password = _passwordController.text;

  //     final response = await http.post(
  //       Uri.parse('https://api.malabarbank.in/api/verifyOtpAndUpdatePassword'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{'password': password}),
  //     );

  //     if (response.statusCode == 200) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => Setpassword()),
  //       );
  //     } else {
  //       // Handle error response
  //       print('Failed to update password.');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: isLandscape ? 30.h : 40),

              Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 150.h),

              Center(
                child: Text(
                  'Create New\n  Password',
                  style: GoogleFonts.poppins(
                    fontSize: isLandscape ? 50 : 30.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Your new password must be different\nfrom previously used passwords',
                  style: GTextStyle.bodyMedium.copyWith(
                    fontSize: isLandscape ? 10.sp : 15.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildADDField(
                      hintText: "Enetr new password",
                      Controller: _passwordController,
                      label: "Password",
                      context: context,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (val.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        return null;
                      },
                      showBorderside: true,
                    ),

                    buildADDField(
                      label: "Confirm Password",
                      hintText: "Re-Enter new password",
                      Controller: _confirmPasswordController,
                      context: context,

                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (val != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      showBorderside: true,
                    ),

                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Congratulation(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              kPrimaryColor.withOpacity(0.610),
                              kPrimaryColor,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Save & Continue',
                          style: GTextStyle.bodyBold.copyWith(
                            fontSize: isLandscape ? 8.sp : 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
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
    );
  }
}
