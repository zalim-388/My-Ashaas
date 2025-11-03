import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:agent_porta/widgets/toggle_boutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LifestyleInterests extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const LifestyleInterests({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<LifestyleInterests> createState() => _LifestyleInterestsState();
}

class _LifestyleInterestsState extends State<LifestyleInterests> {
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final workloctionController = TextEditingController();

  String? selectEatingHabits;
  bool? selectionDrinkingHabits;
  String? selectSalary;

  final List<String> eatingHabitsOptions = [
    "Vegetarian",
    "Non-Vegetarian",
    "Eggetarian",
  ];
  final List<String> educationFieldOptions = [
    "Engineering",
    "Medical",
    "Arts",
    "Commerce",
  ];
  final List<String> salaryOptions = [
    "Below 1 lakh",
    "1-2 lakh",
    "2-3 lakh",
    "3-4 lakh",
    "4-5 lakh",
    "5-6 lakh",
    "6-7 lakh",
    "7-8 lakh",
    "8-9 lakh",
    "9-10 lakh",
    "Above 10 lakh",
  ];
  @override
  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    workloctionController.dispose();
    super.dispose();
  }

  void onEatingHabitsChanged(String? value) {
    setState(() {
      selectEatingHabits = value;
    });
  }

  void onDrinkingHabitsChanged(bool? value) {
    setState(() {
      selectionDrinkingHabits = value;
    });
  }

  void onSalaryChanged(String? value) {
    setState(() {
      selectSalary = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Lifestyle & Interests",

                style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
              ),
              buildDropdown(
                label: "Eating Habits",
                hintText: "Select Eating Habits",
                icon: PhosphorIconsFill.forkKnife,
                onChanged: onEatingHabitsChanged,
                context: context,
                selectedValue: selectEatingHabits,
                options: eatingHabitsOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please selcet  Eating Habits';
                  }
                  return null;
                },
              ),
              buildToggle(
                label: "Drinking Habits",
                selection: selectionDrinkingHabits,
                onChanged: onDrinkingHabitsChanged,
                title: "Yes",
                title1: "No",
              ),

              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    onTap: () {
                      if (widget.formkey.currentState?.validate() ?? false) {
                        widget.pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
