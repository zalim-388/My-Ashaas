import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:agent_porta/widgets/toggle_boutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_info_plus/language_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class personalDetails extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const personalDetails({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<personalDetails> createState() => _personalDetailsState();
}

class _personalDetailsState extends State<personalDetails> {
  final _heigthController = TextEditingController();
  final _weightController = TextEditingController();
  final _motherTongueController = TextEditingController();
  final _starController = TextEditingController();
  final _raasiController = TextEditingController();
  final _differentlyController = TextEditingController();

  String? selectedMaritalStatus;
  String? selectedMotherTongue;
  String? selectionHoroscope;
  String? selectedReligion;
  String? selectedCast;
  String? selectedSubCast;
  String? selectBloodGroup;
  String? selectStar;
  String? selectRaasi;
  String? selectionPhysicalselection;

  List<String> maritalStatuisoptions = [
    "Never",
    "Married",
    "Divorced",
    "Widowed",
    "Separated",
  ];
  List<String> motherTongueOptions = [];
  List<Toggleoption> horoscope = [
    Toggleoption(label: "Yes", icon: Icons.check),
    Toggleoption(label: "No", icon: Icons.close),
  ];
  List<String> religionoptions = [
    "Hindu",
    "Muslim",
    "Christian",
    "Sikh",
    "Jain",
  ];
  List<String> castoptions = [
    "Iyer (Tamil)",
    "Iyengar (Tamil)",
    "Namboothiri (Kerala)",
    "Havyaka (Karnataka)",
  ];
  List<String> subCastoptions = [];
  List<String> bloodGroupOptions = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  List<String> starOptions = [];
  List<String> saasiOptions = [];
  List<Toggleoption> physicalStatusOptions = [
    Toggleoption(label: "Noraml", icon: Icons.person),
    Toggleoption(label: "Differently Abled", icon: Icons.accessible),
  ];
  List<String> getCastForReligion(String? religion) {
    if (religion == 'Hindu') {
      return [
        "Iyer (Tamil)",
        "Iyengar (Tamil)",
        "Namboothiri (Kerala)",
        "Havyaka (Karnataka)",
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

  @override
  void initState() {
    super.initState();
    motherTongueOptions =
        LanguageInfoPlus.languages.map((e) => e.name).toList();
    motherTongueOptions.sort();
  }

  @override
  void dispose() {
    super.dispose();
    _heigthController.dispose();
    _weightController.dispose();
    _starController.dispose();
    _raasiController.dispose();
    _motherTongueController.dispose();
    _differentlyController.dispose();
  }

  void _onMaritalStatusChanged(String? val) {
    setState(() {
      selectedMaritalStatus = val;
    });
  }

  void _onMotherTohgueChanged(String? val) {
    setState(() {
      selectedMotherTongue = val;
      _motherTongueController.text = val!;
    });
  }

  void _onHoroscopeChanged(String? val) {
    setState(() {
      selectionHoroscope = val;
    });
  }

  void _onrReligionChanged(String? val) {
    setState(() {
      selectedReligion = val;
      selectedCast = null;
      selectedSubCast = null;
      castoptions = getCastForReligion(val);
    });
  }

  void _onrCastChanged(String? val) {
    setState(() {
      selectedCast = val;
      selectedSubCast = null;
      subCastoptions = getCastForReligion(val);
    });
  }

  void _onSubCastChanged(String? val) {
    setState(() {
      selectedSubCast = val;
    });
  }

  void _onBloodGroupChanged(String? val) {
    setState(() {
      selectBloodGroup = val;
    });
  }

  void _onStarChanged(String? val) {
    setState(() {
      selectStar = val;
      _starController.text = val!;
    });
  }

  void _onRaasiChanged(String? val) {
    setState(() {
      selectRaasi = val;
      _raasiController.text = val!;
    });
  }

  void _onPhysicalStatusChanged(String? val) {
    setState(() {
      selectionPhysicalselection = val;

      if (selectionPhysicalselection == true) {
        _differentlyController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "personal details",
                style: GTextStyle.heading1Bold.copyWith(color: kTextPrimary),
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    child: buildADDField(
                      showBorderside: true,

                      context: context,
                      label: 'Height (in cm/ft) *',
                      icon: PhosphorIconsFill.ruler,
                      hintText: 'Enter your height',
                      keybordType: TextInputType.number,
                      Controller: _heigthController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter you heigth';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(width: 16.w),
                  Expanded(
                    child: buildADDField(
                      showBorderside: true,

                      context: context,
                      label: 'weight (in Kg) *',
                      icon: PhosphorIconsFill.barbell,
                      hintText: 'Enter your weight',
                      keybordType: TextInputType.number,
                      Controller: _weightController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter you weight';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              buildDropdown(
                showBorderside: true,

                label: "Marital Status *",
                hintText: "Select Marital Status",
                icon: PhosphorIconsFill.heart,
                context: context,
                options: maritalStatuisoptions,
                selectedValue: selectedMaritalStatus,
                onChanged: _onMaritalStatusChanged,
              ),
              buildDropdown(
                showBorderside: true,

                label: "Mother Tongue *",
                hintText: "Select Mother Tongue",
                icon: PhosphorIconsFill.globeStand,
                context: context,
                // controller: motherTongueController,
                options: motherTongueOptions,
                selectedValue: selectedMotherTongue,
                onChanged: _onMotherTohgueChanged,
                isSearchable: true,

                // enabled: true,
              ),

              buildDropdown(
                showBorderside: true,

                label: 'Religion *',
                hintText: 'select Religion',
                icon: PhosphorIconsFill.handsPraying,
                selectedValue: selectedReligion,
                onChanged: _onrReligionChanged,
                context: context,
                options: religionoptions,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please select your Religion';
                  }
                  return null;
                },
              ),
              if (selectedReligion != null && castoptions.isNotEmpty)
                buildDropdown(
                  showBorderside: true,

                  label: 'Cast ',
                  hintText: 'select Cast',
                  icon: PhosphorIconsFill.users,
                  selectedValue: selectedCast,
                  onChanged: _onrCastChanged,
                  context: context,
                  options: castoptions,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    return null;
                  },
                ),
              if (selectedCast != null && subCastoptions.isNotEmpty)
                buildDropdown(
                  showBorderside: true,

                  label: 'Sub Cast ',
                  hintText: 'select Sub Cast',
                  icon: PhosphorIconsFill.treeStructure,
                  selectedValue: selectedSubCast,
                  onChanged: _onSubCastChanged,
                  context: context,
                  options: subCastoptions,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    return null;
                  },
                ),

              buildToggle(
                context: context,
                label: "Horoscope required? *",
                selection: selectionHoroscope,
                onChanged: _onHoroscopeChanged,
                options: horoscope,
                // title: "yes",
                // icon1: Icons.check,
                // title1: "no",
                // icon2: Icons.close,
              ),

              Row(
                children: [
                  Expanded(
                    child: buildDropdown(
                      showBorderside: true,
                      label: 'Star',
                      hintText: 'select star',
                      icon: PhosphorIconsFill.star,
                      selectedValue: selectStar,
                      onChanged: _onStarChanged,
                      context: context,
                      controller: _starController,
                      options: starOptions,
                      isSearchable: true,
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return null;
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  SizedBox(width: 16.w),

                  Expanded(
                    child: buildDropdown(
                   showBorderside: true,
                      label: 'Raasi',
                      hintText: 'select Raasi',
                      icon: PhosphorIconsFill.sparkle,
                      selectedValue: selectBloodGroup,
                      onChanged: _onRaasiChanged,
                      controller: _raasiController,
                      context: context,
                      options: bloodGroupOptions,
                      isSearchable: true,
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return null;
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ],
              ),

              buildDropdown(
                   showBorderside: true,
                label: 'Blood Group *',
                hintText: 'select Blood Group',
                icon: PhosphorIconsFill.drop,
                selectedValue: selectBloodGroup,
                onChanged: _onBloodGroupChanged,
                context: context,
                options: bloodGroupOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  return null;
                },
              ),

              buildToggle(
                
                context: context,
                label: "Physical Status *",
                selection: selectionPhysicalselection,
                onChanged: _onPhysicalStatusChanged,
                options: physicalStatusOptions,

                // title: "Normal ",
                // icon1: Icons.person,
                // title1: "Differently Abled",
                // icon2: Icons.accessible,
              ),
              if (selectionPhysicalselection == "Differently Abled")
                buildADDField(
                   showBorderside: true,
                  context: context,
                  label: "please Specify",
                  hintText: "Hearing impariment",
                  Controller: _differentlyController,
                  icon: Icons.description,
                ),

              SizedBox(height: 20.h),

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
