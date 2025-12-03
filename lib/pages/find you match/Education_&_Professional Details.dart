import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:country_state_city/country_state_city.dart' as csc;

class EducationProfessionalDetails extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const EducationProfessionalDetails({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<EducationProfessionalDetails> createState() =>
      _EducationProfessionalDetailsState();
}

class _EducationProfessionalDetailsState
    extends State<EducationProfessionalDetails> {
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final workloctionController = TextEditingController();

  String? selectEdu;
  String? selectEduField;
  String? selectSalary;

  final List<String> educationOptions = ["Degree", "Diploma", "PG"];
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

  csc.Country? _selectCountry;
  csc.City? _selectcity;

  List<csc.Country> _countries = [];
  List<csc.City> _cities = [];

  List<String> countryOptions = [];
  List<String> cityOptions = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    workloctionController.dispose();
    super.dispose();
  }

  void _loadCountries() async {
    _countries = await csc.getAllCountries();
    setState(() {
      countryOptions = _countries.map((country) => country.name).toList();
    });
  }

  void onCountryChanged(String? value) async {
    if (value == null) return;
    _selectCountry = _countries.firstWhere((country) => country.name == value);
    _cities = await csc.getCountryCities(_selectCountry!.isoCode);
    setState(() {
      cityOptions = _cities.map((city) => city.name).toList();
      _selectcity = null;
    });
  }

  void onCityChanged(String? value) async {
    if (value == null) return;

    setState(() {
      _selectcity = _cities.firstWhere((city) => city.name == value);
    });
  }

  void onEduChanged(String? value) {
    setState(() {
      selectEdu = value;
    });
  }

  void onEduFieldChanged(String? value) {
    setState(() {
      selectEduField = value;
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
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Education & Professional Details",
                style: GTextStyle.heading1Bold.copyWith(color: kTextPrimary),
              ),
              SizedBox(height: 20.h),

              buildDropdown(
                showBorderside: true,
                label: "Education Qualification ",
                hintText: "Select Education Qualification ",
                icon: Icons.school,
                onChanged: onEduChanged,
                context: context,
                selectedValue: selectEdu,
                options: educationOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please selcet education Qualification';
                  }
                  return null;
                },
              ),

              buildDropdown(
                showBorderside: true,
                label: "Education Field ",
                hintText: "Select Education Field ",
                icon: Icons.school,
                onChanged: onEduFieldChanged,
                context: context,
                selectedValue: selectEduField,
                options: educationFieldOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please selcet Education Field ';
                  }
                  return null;
                },
              ),

              buildADDField(
                showBorderside: true,
                context: context,
                label: "Occupation / Job Title",
                hintText: "Enter Job Title",
                Controller: jobTitleController,
                icon: Icons.work_outline,
                keybordType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please  Enter Occupation /Job Title';
                  }
                  return null;
                },
              ),

              buildADDField(
                showBorderside: true,
                context: context,
                label: "Company / Organization Name ",
                hintText: "Enter Company Name",
                Controller: companyController,
                icon: Icons.business,
                keybordType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please  Enter  Company / Organization Name';
                  }
                  return null;
                },
              ),

              buildDropdown(
                showBorderside: true,
                label: "Annual Income / Salary Range",
                hintText: "Select your salary range ",
                icon: Icons.money,
                onChanged: onSalaryChanged,
                context: context,
                selectedValue: selectSalary,
                options: salaryOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please selcet your income';
                  }
                  return null;
                },
              ),

              buildFieldLabel(
                label: "Work Location *",
                context: context,
                icon: PhosphorIconsFill.buildings,
              ),

              buildDropdown(
                showBorderside: true,
                context: context,
                label: "Country *",
                fontSize: 16.spMin,
                hintText: "Search your country",
                icon: Icons.public,
                options: countryOptions,
                selectedValue: _selectCountry?.name,
                isSearchable: true,
                onChanged: onCountryChanged,
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please select a country"
                            : null,
              ),

              if (_selectCountry != null && cityOptions.isNotEmpty)
                buildDropdown(
                  showBorderside: true,
                  context: context,
                  label: "City *",
                  hintText: "Search your City",
                  fontSize: 16.spMin,
                  icon: Icons.map_outlined,
                  options: cityOptions,
                  isSearchable: true,
                  selectedValue: _selectcity?.name,
                  onChanged: onCityChanged,
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? "Please select  City"
                              : null,
                ),

              SizedBox(height: 48.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    context: context,
                    loading: _isLoading,
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
































// import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
// import 'package:agent_porta/widgets/Bg_continer.dart';
// import 'package:agent_porta/widgets/Text_field.dart';
// import 'package:agent_porta/widgets/dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:country_state_city/country_state_city.dart' as csc;

// class EducationProfessionalDetails extends StatefulWidget {
//   final PageController pageController;
//   final GlobalKey<FormState> formkey;
//   const EducationProfessionalDetails({
//     super.key,
//     required this.pageController,
//     required this.formkey,
//   });

//   @override
//   State<EducationProfessionalDetails> createState() =>
//       _EducationProfessionalDetailsState();
// }

// class _EducationProfessionalDetailsState
//     extends State<EducationProfessionalDetails> {
//   final jobTitleController = TextEditingController();
//   final companyController = TextEditingController();
//   final workloctionController = TextEditingController();

//   String? selectEdu;
//   String? selectEduField;
//   String? selectSalary;

//   final List<String> educationOptions = ["Degree", "Diploma", "PG"];
//   final List<String> educationFieldOptions = [
//     "Engineering",
//     "Medical",
//     "Arts",
//     "Commerce",
//   ];
//   final List<String> salaryOptions = [
//     "Below 1 lakh",
//     "1-2 lakh",
//     "2-3 lakh",
//     "3-4 lakh",
//     "4-5 lakh",
//     "5-6 lakh",
//     "6-7 lakh",
//     "7-8 lakh",
//     "8-9 lakh",
//     "9-10 lakh",
//     "Above 10 lakh",
//   ];

//   csc.Country? _selectCountry;
//   csc.City? _selectcity;

//   List<csc.Country> _countries = [];
//   List<csc.City> _cities = [];

//   List<String> countryOptions = [];
//   List<String> cityOptions = [];

//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadCountries();
//   }

//   @override
//   void dispose() {
//     jobTitleController.dispose();
//     companyController.dispose();
//     workloctionController.dispose();
//     super.dispose();
//   }

//   void _loadCountries() async {
//     _countries = await csc.getAllCountries();
//     setState(() {
//       countryOptions = _countries.map((country) => country.name).toList();
//     });
//   }

//   void onCountryChanged(String? value) async {
//     if (value == null) return;
//     _selectCountry = _countries.firstWhere((country) => country.name == value);
//     _cities = await csc.getCountryCities(_selectCountry!.isoCode);
//     setState(() {
//       cityOptions = _cities.map((city) => city.name).toList();
//       _selectcity = null;
//     });
//   }

//   void onCityChanged(String? value) async {
//     if (value == null) return;

//     setState(() {
//       _selectcity = _cities.firstWhere((city) => city.name == value);
//     });
//   }

//   void onEduChanged(String? value) {
//     setState(() {
//       selectEdu = value;
//     });
//   }

//   void onEduFieldChanged(String? value) {
//     setState(() {
//       selectEduField = value;
//     });
//   }

//   void onSalaryChanged(String? value) {
//     setState(() {
//       selectSalary = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: widget.formkey,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               buildFindyouTitle("Education & Professional Details"),
//               SizedBox(height: 24.h),
//               buildBgCard(
//                 context: context,

//                 child: Column(
//                   children: [
//                     buildBgCardTitle(
//                       context: context,
//                       title: "Education Details",
//                       icon: Icons.school,
//                     ),

//                     SizedBox(height: 16.h),

//                     buildDropdown(
//                       label: "Education Qualification ",
//                       hintText: "Select Education Qualification ",
//                       icon: Icons.school,
//                       onChanged: onEduChanged,
//                       context: context,
//                       selectedValue: selectEdu,
//                       options: educationOptions,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please selcet education Qualification';
//                         }
//                         return null;
//                       },
//                     ),

//                     buildDropdown(
//                       label: "Education Field ",
//                       hintText: "Select Education Field ",
//                       icon: Icons.school,
//                       onChanged: onEduFieldChanged,
//                       context: context,
//                       selectedValue: selectEduField,
//                       options: educationFieldOptions,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please selcet Education Field ';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.h),

//               buildBgCard(
//                 context: context,
//                 child: Column(
//                   children: [
//                     buildBgCardTitle(
//                       context: context,
//                       title: "Professional Details",
//                       icon: Icons.work,
//                     ),
//                     SizedBox(height: 16.h),

//                     buildADDField(
//                       context: context,
//                       label: "Occupation / Job Title",
//                       hintText: "Enter Job Title",
//                       Controller: jobTitleController,
//                       icon: Icons.work_outline,
//                       keybordType: TextInputType.name,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please  Enter Occupation /Job Title';
//                         }
//                         return null;
//                       },
//                     ),
//                     buildADDField(
//                       context: context,
//                       label: "Company / Organization Name ",
//                       hintText: "Enter Company Name",
//                       Controller: companyController,
//                       icon: Icons.business,
//                       keybordType: TextInputType.name,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please  Enter  Company / Organization Name';
//                         }
//                         return null;
//                       },
//                     ),

//                     buildDropdown(
//                       label: "Annual Income / Salary Range",
//                       hintText: "Select your salary range ",
//                       icon: Icons.money,
//                       onChanged: onSalaryChanged,
//                       context: context,
//                       selectedValue: selectSalary,
//                       options: salaryOptions,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please selcet your income';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               buildBgCard(
//                 context: context,
//                 child: Column(
//                   children: [
//                     buildBgCardTitle(
//                       context: context,
//                       title: "Work Location",
//                       icon: PhosphorIconsFill.buildings,
//                     ),

//                     SizedBox(height: 16.h),

//                     buildDropdown(
//                       context: context,
//                       label: "Country *",
//                       fontSize: 12.sp,
//                       hintText: "Search your country",
//                       icon: Icons.public,
//                       options: countryOptions,
//                       selectedValue: _selectCountry?.name,
//                       isSearchable: true,
//                       onChanged: onCountryChanged,
//                       validator:
//                           (value) =>
//                               (value == null || value.isEmpty)
//                                   ? "Please select a country"
//                                   : null,
//                     ),

//                     if (_selectCountry != null && cityOptions.isNotEmpty)
//                       buildDropdown(
//                         context: context,
//                         label: "City *",
//                         hintText: "Search your City",
//                         fontSize: 12.sp,
//                         icon: Icons.map_outlined,
//                         options: cityOptions,
//                         isSearchable: true,
//                         selectedValue: _selectcity?.name,
//                         onChanged: onCityChanged,
//                         validator:
//                             (value) =>
//                                 (value == null || value.isEmpty)
//                                     ? "Please select a state"
//                                     : null,
//                       ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 48.h),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   buildNextButton(
//                     context: context,
//                     loading: _isLoading,
//                     onTap: () {
//                       if (widget.formkey.currentState?.validate() ?? false) {
//                         widget.pageController.nextPage(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



