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
  String? selectionDrinkingHabits;
  String? selectSalary;
  String? selectionSmokingHabits;
  Set<String>? selectHobbiesInterests;
  String? selectedReligion;
  String? selectedCast;
  Set<String>? selecteLifestylePreferences;

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
  final List<Toggleoption> drinkingHabitsOptions = [
    Toggleoption(label: "Yes", icon: Icons.check),
    Toggleoption(label: "No", icon: Icons.close),
    Toggleoption(label: "Occasionally", icon: PhosphorIconsFill.sparkle),
  ];
  final List<Toggleoption> smokingHabitsOptions = [
    Toggleoption(label: "Yes", icon: Icons.check),
    Toggleoption(label: "No", icon: Icons.close),
    Toggleoption(label: "Occasionally", icon: PhosphorIconsFill.sparkle),
  ];
  final List<Toggleoption> hobbiesInterestsOptions = [
    Toggleoption(label: "Music", icon: PhosphorIconsFill.musicNote),
    Toggleoption(label: "Reading", icon: PhosphorIconsFill.bookOpen),
    Toggleoption(label: "Movies ", icon: PhosphorIconsFill.filmStrip),
    Toggleoption(label: "Travel", icon: PhosphorIconsFill.airplane),
    Toggleoption(label: "Cooking", icon: PhosphorIconsFill.cookie),
    Toggleoption(label: "Sports", icon: PhosphorIconsFill.bicycle),
  ];
  List<String> religionoptions = [
    "Hindu",
    "Muslim",
    "Christian",
    "Sikh",
    "Jain",
  ];
  List<String> castoptions = [];
  List<String> getCastForReligion(String? religion) {
    if (religion == 'Hindu') {
      return [
        "Iyer ",
        "Iyengar ",
        "Namboothiri ",
        "Havyaka ",
        "Smartha ",
        "adhwa ",
      ];
    }
    if (religion == 'Muslim') {
      return [];
    }
    if (religion == 'Christian') {
      return ["cast B1", "cast B2", "cast B3"];
    }
    if (religion == 'Sikh') {
      return ["cast A1", "cast A2", "cast A3", "cast A4"];
    }
    if (religion == 'Jain') {
      return [];
    }
    return [];
  }

  final List<Toggleoption> lifestylePreferencesOptions = [
    Toggleoption(label: "Veg", icon: PhosphorIconsFill.leaf),
    Toggleoption(label: "Non-Veg", icon: Icons.set_meal),
    Toggleoption(label: "Smoking", icon: PhosphorIconsFill.cigarette),
    Toggleoption(label: "Drinking", icon: PhosphorIconsFill.wine),
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

  void onDrinkingHabitsChanged(String? value) {
    setState(() {
      selectionDrinkingHabits = value;
    });
  }

  void onSalaryChanged(String? value) {
    setState(() {
      selectSalary = value;
    });
  }

  void onsmockingHabitsChanged(String? value) {
    setState(() {
      selectionSmokingHabits = value;
    });
  }

  void onhobbiesInterestsChanged(Set<String>? value) {
    setState(() {
      selectHobbiesInterests = value;
    });
  }

  void _onrReligionChanged(String? val) {
    setState(() {
      selectedReligion = val;
      selectedCast = null;
      // selectedSubCast = null;
      castoptions = getCastForReligion(val);
    });
  }

  void _onrCastChanged(String? val) {
    setState(() {
      selectedCast = val;
      //  selectedCast = null;
      // = getCastForReligion(val);
    });
  }

  void _onLifestylePreferencesChanged(Set<String>? val) {
    setState(() {
      selecteLifestylePreferences = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Form(
      key: widget.formkey,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Lifestyle & Interests",

                style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
              ),
              SizedBox(height: 20.h),

              buildDropdown(
                label: "Eating Habits *",
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

              if (isLandscape) ...[
                Row(
                  children: [
                    Expanded(
                      child: buildToggleSingChip(
                        context: context,
                        label: "Drinking Habits",
                        options: drinkingHabitsOptions,
                        selection: selectionDrinkingHabits,
                        onChanged: onDrinkingHabitsChanged,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: buildToggleSingChip(
                        context: context,
                        label: "Smoking Habits",
                        options: smokingHabitsOptions,
                        selection: selectionSmokingHabits,
                        onChanged: onsmockingHabitsChanged,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                buildToggleSingChip(
                  context: context,
                  label: "Drinking Habits",
                  options: drinkingHabitsOptions,
                  selection: selectionDrinkingHabits,
                  onChanged: onDrinkingHabitsChanged,
                ),

                buildToggleSingChip(
                  context: context,
                  label: "Smoking Habits",
                  options: smokingHabitsOptions,
                  selection: selectionSmokingHabits,
                  onChanged: onsmockingHabitsChanged,
                ),
              ],
              buildToggleMultiChip(
                context: context,
                label: "Hobbies & Interests",
                options: hobbiesInterestsOptions,
                selection: selectHobbiesInterests,
                onChanged: onhobbiesInterestsChanged,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Expanded(
                    child: buildDropdown(
                      label: "Religion",
                      selectedValue: selectedReligion,
                      hintText: "select Religion",
                      options: religionoptions,
                      icon: PhosphorIconsFill.handsPraying,
                      onChanged: _onrReligionChanged,
                      context: context,
                      isSearchable: true,
                    ),
                  ),

                  if (castoptions.isNotEmpty) ...[
                    SizedBox(width: 16.w),

                    Expanded(
                      child: buildDropdown(
                        label: "Cast",
                        selectedValue: selectedCast,
                        options: castoptions,
                        icon: PhosphorIconsFill.users,
                        hintText: "select Cast",
                        onChanged: _onrCastChanged,
                        context: context,
                        isSearchable: true,
                      ),
                    ),
                  ],
                ],
              ),

              buildToggleMultiChip(
                context: context,
                label: "Lifestyle Preferences ",
                options: lifestylePreferencesOptions,
                selection: selecteLifestylePreferences,
                onChanged: _onLifestylePreferencesChanged,
              ),

              // buildToggle(
              //   label: "Smoking Habits",
              //   selection: selectionSmokingHabits,
              //   onChanged: onsmockingHabitsChanged,
              //   options: SmokingHabitsOptions,
              //   // title: "Yes",
              //   // title1: "No",
              // ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    context: context,
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
