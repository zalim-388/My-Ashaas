import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/Congratulation.dart';
import 'package:my_ashaas/pages/Forget%20password/Reset_password_verify.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Appbar.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:my_ashaas/widgets/buttons.dart';


class EnterNewPass extends StatefulWidget {
  final String otp;
  const EnterNewPass({super.key, required this.otp});

  @override
  EnterNewPassState createState() => EnterNewPassState();
}

class EnterNewPassState extends State<EnterNewPass> {
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
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(isLandscape ? 48.h : 56.h),
        child: buildAppbar(
          appbarColor: kBackgroundColor,
          onPressedLeading: () {
             Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordVerify(otp: ''),
                    ),
                  );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
         

              SizedBox(height: isLandscape ? 30.h : 140.h),

              Center(
                child: Text(
                  'Create New\n  Password',
                  style: GTextStyle.display.copyWith(color: kTextblod),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Your new password must be different\nfrom previously used passwords',
                  style: GTextStyle.bodyMedium.copyWith(color: Colors.black54),
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

                    SizedBox(height: 45.h),

                    buildButtions(
                      context: context,
                      label: "Save & Continue",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Congratulation(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.0.h),
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
