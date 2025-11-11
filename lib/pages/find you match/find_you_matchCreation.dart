import 'package:agent_porta/pages/find%20you%20match/Education_&_Professional%20Details.dart';
import 'package:agent_porta/pages/find%20you%20match/Lifestyle_&_Interests.dart';
import 'package:agent_porta/pages/find%20you%20match/Partner_Preferences.dart';
import 'package:agent_porta/pages/find%20you%20match/family_details.dart';
import 'package:agent_porta/pages/find%20you%20match/personal_Details.dart';
import 'package:agent_porta/pages/find%20you%20match/registrationscreen.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uicons/uicons.dart';
import '../../styles/style.dart';
import '../home_page.dart';

enum Gender { male, female, other }

class FindYouMatchcreation extends StatefulWidget {
  const FindYouMatchcreation({super.key});

  @override
  State<FindYouMatchcreation> createState() => _FindYouMatchcreationState();
}

class _FindYouMatchcreationState extends State<FindYouMatchcreation> {
  final _pageController = PageController();

  int _currentPage = 0;

  final _page1FormKey = GlobalKey<FormState>();
  final _page2FormKey = GlobalKey<FormState>();
  final _page3FormKey = GlobalKey<FormState>();
  final _page4Formkey = GlobalKey<FormState>();
  final _page5Formkey = GlobalKey<FormState>();
  final _page6Formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: 50.h,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Find You Match',
          style: GTextStyle.bodyBold.copyWith(
            fontSize: isLandscape ? 11.sp : 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        titleSpacing: 30.w,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15.w),
        leading: IconButton(
          onPressed: () {
            if (_currentPage == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          icon: Icon(UIcons.solidRounded.angle_left, size: 15),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: Container(
              height: 30.h,
              width: isLandscape ? 20.w : 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                color: kPrimaryColor,
              ),
              alignment: Alignment.center,
              child: Text(
                "Skip",
                style: GTextStyle.bodyBold.copyWith(
                  fontSize: isLandscape ? 7.sp : 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          children: [
            registrationscreen(
              formkey: _page1FormKey,
              pageController: _pageController,
            ),

            personalDetails(
              pageController: _pageController,
              formkey: _page2FormKey,
            ),
            FamilyDetails(
              pageController: _pageController,
              formkey: _page3FormKey,
            ),
            EducationProfessionalDetails(
              formkey: _page4Formkey,
              pageController: _pageController,
            ),
            LifestyleInterests(
              pageController: _pageController,
              formkey: _page5Formkey,
            ),
            PartnerPreferences(
              formkey: _page6Formkey,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildNextButton({
  required VoidCallback onTap,
  bool loading = false,
  required BuildContext context,
  String text = "Next",
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return GestureDetector(
    onTap: loading ? null : onTap,
    child: Container(
      width: isLandscape ? 40.w : 70.w,
      height: isLandscape ? 40.h : 35.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Next',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 9.sp : 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: isLandscape ? 3.w : 5.w),
            if (loading)
              SizedBox(
                height: isLandscape ? 20.h : 15.h,
                width: isLandscape ? 20.w : 15.w,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            else
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
                size: 15,
              ),
          ],
        ),
      ),
    ),
  );
}
