import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:my_ashaas/widgets/dropdown.dart';
import 'package:my_ashaas/widgets/toggle_boutton.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FamilyDetails extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const FamilyDetails({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _lateFatherController = TextEditingController();
  final _lateMotherController = TextEditingController();
  final _totalsistersController = TextEditingController();
  final _totalbrothersController = TextEditingController();
  final _hometownController = TextEditingController();
  final _othersfathersOccuptionController = TextEditingController();
  final _othersmotherOccuptionController = TextEditingController();
  final _totalmarriedController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  // final _districtController = TextEditingController();

  String? _selectionFatherStatus;
  String? _selectionMotherStatus;
  String? _selectedfamilystatus;
  String? _selectFamilytype;
  String? _selectFatherOccupation;
  String? _selectMotherOccupation;
  // String? _selectDistrict;

  final List<String> occuptionmotherOptions = [
    "House Wife",
    "Self Employed",
    "Private",
    "Government job",
    "Business",
    "Others",
  ];

  final List<String> occuptionfatherOptions = [
    "Self Employed",
    "Private",
    "Government job",
    "Business",
    "Others",
  ];

  final List<String> familytypeOptions = [" Joint ", "Nuclea"];

  final List<String> familystatusOptions = ["Middle,", "Rich", "Affluent"];

  final List<String> profileoptions = [
    "Self",
    "Parent",
    "Sibling",
    'Friend',
    "Relative",
  ];
  final List<Toggleoption> fatherstatusOptions = [
    Toggleoption(label: "Alive", icon: Icons.person),
    Toggleoption(label: "Late", icon: Icons.bookmark),
  ];
  final List<Toggleoption> motherStatusOptions = [
    Toggleoption(label: "Alive", icon: Icons.person),
    Toggleoption(label: "Late", icon: Icons.bookmark),
  ];

  List<csc.Country> _countries = [];
  List<csc.State> _states = [];
  List<csc.City> _cities = [];
  // List<String> _districts = [];

  List<String> countryOptions = [];
  List<String> stateOptions = [];
  List<String> cityOptions = [];

  csc.Country? _selectCountry;
  csc.State? _selectState;
  csc.City? _selectCity;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void dispose() {
    super.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _totalbrothersController.dispose();
    _totalsistersController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
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
    _states = await csc.getStatesOfCountry(_selectCountry!.isoCode);

    setState(() {
      stateOptions = _states.map((state) => state.name).toList();
      _selectState = null;
      // _stateController.clear();
      cityOptions = [];
      _selectCity = null;
      // _cityController.clear();
    });
  }

  void onStateChanged(String? value) async {
    if (value == null) return;
    _selectState = _states.firstWhere((state) => state.name == value);
    _cities = await csc.getStateCities(
      _selectCountry!.isoCode,
      _selectState!.isoCode,
    );

    setState(() {
      cityOptions = _cities.map((city) => city.name).toList();
      _selectCity = null;
      // _cityController.clear();
    });
  }

  void onCityChanged(String? value) async {
    if (value == null) return;
    setState(() {
      _selectCity = _cities.firstWhere((city) => city.name == value);
    });
  }

  void onDistrictChanged(String? value) async {}
  void _onFatherStatusChanged(newValue) {
    setState(() {
      _selectionFatherStatus = newValue;
      if (newValue == true) {
        _lateFatherController.clear();
      } else {
        _selectFatherOccupation = null;
        _othersfathersOccuptionController.clear();
      }
    });
  }

  void _onOccupationFatherChanged(newValue) {
    setState(() {
      _selectFatherOccupation = newValue;
      if (newValue != "Others") {
        _othersfathersOccuptionController.clear();
      }
    });
  }

  void _onMotherStatusChanged(newValue) {
    setState(() {
      _selectionMotherStatus = newValue;
      if (newValue == true) {
        _lateMotherController.clear();
      } else {
        _selectMotherOccupation = null;
        _othersmotherOccuptionController.clear();
      }
    });
  }

  void _onOccupationMotherChanged(newValue) {
    setState(() {
      _selectMotherOccupation = newValue;
      if (newValue != "Others") {
        _othersmotherOccuptionController.clear();
      }
    });
  }

  void _onfamilytypeChanged(newValue) {
    setState(() {
      _selectFamilytype = newValue;
    });
  }

  void _onfamilystatusChanged(newValue) {
    setState(() {
      _selectedfamilystatus = newValue;
    });
  }

  void _onbroCount(value) {
    setState(() {
      final int totalBro = int.tryParse(_totalbrothersController.text) ?? 0;
      final int totalSis = int.tryParse(_totalsistersController.text) ?? 0;
      final int totalmarried = int.tryParse(_totalmarriedController.text) ?? 0;

      if (totalmarried > (totalBro + totalSis)) {
        _totalmarriedController.clear();
      }

      if (totalSis == 0 && totalBro == 0) {
        _totalmarriedController.clear();
      }
    });
  }

  void _onSisCount(value) {
    setState(() {
      final int totalBro = int.tryParse(_totalbrothersController.text) ?? 0;
      final int totalSis = int.tryParse(_totalsistersController.text) ?? 0;
      final int totalmarried = int.tryParse(_totalmarriedController.text) ?? 0;

      if (totalmarried > (totalBro + totalSis)) {
        _totalmarriedController.clear();
      }

      if (totalSis == 0 && totalBro == 0) {
        _totalmarriedController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalBro = int.tryParse(_totalbrothersController.text) ?? 0;
    final int totalSis = int.tryParse(_totalsistersController.text) ?? 0;
    return Form(
      key: widget.formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),
          child: Column(
            children: [
              Text(
                "Family details",
                style: GTextStyle.heading1Bold.copyWith(color: kTextPrimary),
              ),

              buildADDField(
                showBorderside: true,

                context: context,
                label: "Father Name *",
                hintText: "Enter Father Name",
                Controller: _fatherNameController,
                keybordType: TextInputType.name,
                icon: PhosphorIconsFill.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Father Name';
                  }
                  return null;
                },
              ),

              buildToggleSingChip(
                context: context,
                label: "Father Status *",
                selection: _selectionFatherStatus,
                onChanged: _onFatherStatusChanged,
                options: fatherstatusOptions,
                // title: "Alive",
                // title1: "Late",
                // icon1: Icons.person,
                // icon2: Icons.bookmark,
              ),
              if (_selectionFatherStatus == "Alive") ...[
                buildDropdown(
                  showBorderside: true,

                  label: "Father Occupation",
                  hintText: "selcet an Occupation",
                  options: occuptionfatherOptions,
                  onChanged: _onOccupationFatherChanged,
                  icon: Icons.work_outline,
                  context: context,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please selcet an Occuptation';
                    }
                    return null;
                  },
                ),
              ],
              if (_selectFatherOccupation == "Others")
                buildADDField(
                  showBorderside: true,

                  context: context,
                  label: "Please Specfiy",
                  hintText: "Enter Occupation",
                  Controller: _othersfathersOccuptionController,
                  keybordType: TextInputType.name,
                  icon: PhosphorIconsFill.pen,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please  Enter Occupation';
                    }
                    return null;
                  },
                )
              else if (_selectionFatherStatus == "Late") ...[
                buildADDField(
                  showBorderside: true,

                  context: context,
                  label: "Which year",
                  hintText: "Enter year ",
                  Controller: _lateFatherController,
                  keybordType: TextInputType.number,
                  icon: Icons.calendar_today,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter year';
                    }
                    return null;
                  },
                ),
              ],

              buildADDField(
                showBorderside: true,

                context: context,
                label: "Mother Name",
                hintText: "Enter Mother Name",
                Controller: _motherNameController,
                keybordType: TextInputType.name,
                icon: PhosphorIconsFill.person,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Mother Name';
                  }
                  return null;
                },
              ),
              buildToggleSingChip(
                context: context,
                label: "Mother Status",
                selection: _selectionMotherStatus,
                onChanged: _onMotherStatusChanged,
                options: motherStatusOptions,
                // title: "Alive",
                // title1: "Late",
                // icon1: Icons.person,
                // icon2: Icons.bookmark,
              ),

              if (_selectionMotherStatus == "Alive") ...[
                buildDropdown(
                  showBorderside: true,

                  label: "Mother Occupation",
                  hintText: "select an Occupation",
                  context: context,
                  onChanged: _onOccupationMotherChanged,
                  options: occuptionmotherOptions,
                  icon: Icons.work_outline,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please  select an Occuptation';
                    }
                    return null;
                  },
                ),
              ],
              if (_selectMotherOccupation == "Others")
                buildADDField(
                  showBorderside: true,

                  context: context,
                  label: "Please Specfiy",
                  hintText: "Enter Occupation",
                  Controller: _othersmotherOccuptionController,
                  keybordType: TextInputType.name,
                  icon: PhosphorIconsFill.pen,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please  Enter Occupation';
                    }
                    return null;
                  },
                )
              else if (_selectionMotherStatus == "Late") ...[
                buildADDField(
                  showBorderside: true,

                  context: context,
                  label: "which year",
                  hintText: "Enter year",
                  Controller: _lateMotherController,
                  keybordType: TextInputType.number,
                  icon: Icons.calendar_today,

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter year';
                    }
                    return null;
                  },
                ),
              ],

              buildDropdown(
                showBorderside: true,

                label: "Family type *",
                hintText: "select family type",
                onChanged: _onfamilytypeChanged,
                selectedValue: _selectFamilytype,
                context: context,
                options: familytypeOptions,
                icon: PhosphorIconsFill.house,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please select Family Type";
                  }
                  return null;
                },
              ),
              buildDropdown(
                showBorderside: true,

                label: 'Family Status*',
                hintText: 'select  Family Status',
                icon: Icons.family_restroom,
                selectedValue: _selectedfamilystatus,
                onChanged: _onfamilystatusChanged,
                context: context,
                options: familystatusOptions,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  return null;
                },
              ),
              buildFieldLabel(label: "Sibilings", context: context),

              Row(
                children: [
                  Expanded(
                    child: buildADDField(
                      showBorderside: true,

                      context: context,
                      label: "Number of brothers",
                      fontSize: 16.spMin,
                      Controller: _totalbrothersController,
                      keybordType: TextInputType.number,
                      icon: Icons.male,
                      hintText: "No. of Brothers",
                      onChanged: _onbroCount,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: buildADDField(
                      showBorderside: true,

                      context: context,
                      label: "Numbers of Sisters",
                      fontSize: 16.spMin,
                      Controller: _totalsistersController,
                      keybordType: TextInputType.number,
                      hintText: "No. of Sisters",
                      icon: Icons.female,
                      onChanged: _onSisCount,
                    ),
                  ),
                  SizedBox(width: 5.w),

                  if (totalBro > 0 || totalSis > 0)
                    Expanded(
                      child: buildADDField(
                        showBorderside: true,

                        context: context,
                        label: "TotalMarried Count",
                        fontSize: 12.sp,
                        Controller: _totalmarriedController,
                        keybordType: TextInputType.number,
                        hintText: "Enter married Count",
                        icon: Icons.family_restroom_outlined,
                        validator: (value) {
                          final int totalMarried =
                              int.tryParse(_totalmarriedController.text) ?? 0;
                          if (totalBro + totalSis < totalMarried) {
                            return 'Must be less than total siblings';
                          }
                          return null;
                        },
                      ),
                    ),
                ],
              ),

              buildADDField(
                showBorderside: true,

                context: context,
                label: "Native Place / Hometown",
                hintText: "Enter your home",
                Controller: _hometownController,
                icon: PhosphorIconsFill.mapPin,
                validator: (value) {
                  if (value == null || value.isEmpty == false) {
                    return 'pleasse enter your hometown';
                  }
                  return null;
                },
              ),

              buildFieldLabel(
                label: "Current Residence Address",
                context: context,
                icon: PhosphorIconsFill.house,
              ),
              buildDropdown(
                showBorderside: true,

                context: context,
                label: "Country *",
                hintText: "Search your country",
                icon: Icons.public,
                options: countryOptions,
                // controller: _countryController,
                selectedValue: _selectCountry?.name,
                isSearchable: true,
                onChanged: onCountryChanged,
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? "Please select a country"
                            : null,
              ),

              if (_selectCountry != null && stateOptions.isNotEmpty)
                buildDropdown(
                  showBorderside: true,

                  context: context,
                  label: "State *",
                  hintText: "Search your state",
                  icon: Icons.map,
                  options: stateOptions,
                  // controller: _stateController,
                  isSearchable: true,
                  selectedValue: _selectState?.name,
                  onChanged: onStateChanged,
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? "Please select a state"
                              : null,
                ),

              if (_selectState != null && cityOptions.isNotEmpty)
                buildDropdown(
                  showBorderside: true,

                  context: context,
                  label: "City *",
                  hintText: "Search your city",
                  icon: PhosphorIconsFill.city,
                  options: cityOptions,
                  // controller: _cityController,
                  isSearchable: true,
                  selectedValue: _selectCity?.name,
                  onChanged: onCityChanged,
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? "Please select a city"
                              : null,
                ),
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
