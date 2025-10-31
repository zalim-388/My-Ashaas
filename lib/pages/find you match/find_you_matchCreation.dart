import 'dart:io';
import 'package:agent_porta/pages/find%20you%20match/personal_Details.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
  final _fullnameController = TextEditingController();
  final _agetController = TextEditingController();
  final _dobtController = TextEditingController();
  final _emailController = TextEditingController();

  final _heigthController = TextEditingController();
  final _weightController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _gstNumberController = TextEditingController();
  final _aadhaarNumberController = TextEditingController();
  final _nomineeController = TextEditingController();
  final _nomineeNumberController = TextEditingController();
  final _pageController = PageController();

  int _currentPage = 0;

  final _page1FormKey = GlobalKey<FormState>();
  final _page2FormKey = GlobalKey<FormState>();

  Gender? _selectedGender = Gender.male;
  String? selectedvalve;
  final List<String> options = [
    "Self",
    "Parent",
    "Sibling",
    'Friend',
    "Relative",
  ];

  final List<String> MaritalStatus=[
   "Never", "Married" ,"Divorced" , "Widowed",  "Separated",
  ];

  List<File> _selectedFiles = [];
  final int _maxFiles = 10;
  final int _minFiles = 3;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFiles() async {
    if (_selectedFiles.length >= _maxFiles) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You can only select up to $_maxFiles files',
            style: TextStyle(fontSize: 12, fontFamily: 'qs'),
          ),
          backgroundColor: kPrimaryColor,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          height: 200.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select Pictures',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'qs',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                      _getImageFromCamera();
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: kPrimaryColor.withOpacity(.1),
                          child: Icon(
                            Ionicons.camera,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: 'qs',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gallery option
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                      _getImageFromGallery();
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: kPrimaryColor.withOpacity(.1),
                          child: Icon(
                            Ionicons.images,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontFamily: 'qs',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImageFromCamera() async {
    if (_selectedFiles.length >= _maxFiles) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum $_maxFiles files allowed'),
          backgroundColor: kPrimaryColor,
        ),
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedFiles.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    int remainingSlots = _maxFiles - _selectedFiles.length;
    if (remainingSlots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum $_maxFiles files allowed'),
          backgroundColor: kPrimaryColor,
        ),
      );
      return;
    }

    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 85,
    );

    if (pickedFiles.isNotEmpty) {
      List<File> newFiles =
          pickedFiles
              .take(remainingSlots)
              .map((file) => File(file.path))
              .toList();

      if (newFiles.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(newFiles);
        });
      }

      if (pickedFiles.length > remainingSlots) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You can only select up to $_maxFiles files. ${pickedFiles.length - remainingSlots} files were ignored.',
              style: TextStyle(fontSize: 12, fontFamily: 'qs'),
            ),
            backgroundColor: kPrimaryColor,
          ),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final DateTime today = DateTime.now();
      int age = today.year - pickedDate.year;
      if (today.month < pickedDate.month ||
          (today.month == pickedDate.month && today.day < pickedDate.day)) {
        age--;
      }
      setState(() {
        _dobtController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        _agetController.text = "$age ";
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _countryController.text = 'India';
    _stateController.text = 'Kerala';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fullnameController.dispose();
    _agetController.dispose();
    _dobtController.dispose();
    _emailController.dispose();
    _heigthController.dispose();
    _weightController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _gstNumberController.dispose();
    _aadhaarNumberController.dispose();
    _nomineeController.dispose();
    _nomineeNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Find You Match',
          style: GTextStyle.bodyBold.copyWith(
            fontSize: 18.sp,
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
      ),
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
            buildregistrationscreen(_pageController),
            buildpersonalDetails(
              _pageController,
              _page2FormKey,
              _heigthController,
              _weightController,
              context,
              MaritalStatus.map((e) => e.,).toList();
              selectedvalve,
     
              
              
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderField({
    required String label,
    IconData? icon,
    double? topPad,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildFieldLabel(label: label, icon: icon, topPad: topPad),

        SegmentedButton<Gender>(
          segments: <ButtonSegment<Gender>>[
            ButtonSegment(
              value: Gender.male,
              icon: Icon(Icons.male),
              label: Text('Male'),
            ),
            ButtonSegment(
              value: Gender.female,
              icon: Icon(Icons.female),
              label: Text('Female'),
            ),
            ButtonSegment(
              value: Gender.other,
              label: Text('Others'),
              icon: Icon(Icons.help_outline_outlined),
            ),
          ],

          selected: <Gender>{if (_selectedGender != null) _selectedGender!},
          onSelectionChanged: (Set<Gender> newSelection) {
            setState(() {
              if (newSelection.isNotEmpty) {
                setState(() {
                  _selectedGender = newSelection.first;
                });
              }
            });
          },
          style: SegmentedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            selectedBackgroundColor: kPrimaryColor,
            selectedForegroundColor: Colors.white,
            side: BorderSide.none,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildregistrationscreen(PageController _pageController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 40.h),
      child: Form(
        key: _page1FormKey,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Registration Details",
                style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
              ),
              SizedBox(height: 20.h),

              buildBusinessField(
                label: 'Full Name *',
                icon: PhosphorIconsFill.userCircle,
                hintText: 'Enter Full Name',
                Controller: _fullnameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
              ),

              _buildGenderField(
                label: 'Gender *',
                icon: PhosphorIconsFill.genderMale,
              ),

              Row(
                children: [
                  Expanded(
                    child: buildBusinessField(
                      label: 'Date of Birth *',
                      icon: PhosphorIconsFill.calendar,
                      hintText: 'Select your Date of Birth',
                      Controller: _dobtController,
                      readOnly: true,
                      onTap: () async {
                        _selectDate(context);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: buildBusinessField(
                      label: 'Age *',
                      icon: PhosphorIconsFill.user,
                      hintText: 'your Age',
                      Controller: _agetController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              buildBusinessField(
                label: 'Email Id',
                icon: PhosphorIconsFill.envelope,
                hintText: 'Enter Email Id',
                Controller: _emailController,
                keybordType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              buildDropdown(
                label: "Profile Created by",
                onChanged: (newvalue) {
                  setState(() {
                    selectedvalve = newvalue;
                  });
                },
                context: context,
                options: options.map((e) => e).toList(),
                hintText: "Select Profile Created by",
                selectedValue: selectedvalve,
                icon: PhosphorIconsFill.userCircle,
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    onTap: () {
                      if (_page1FormKey.currentState!.validate()) {
                        _pageController.nextPage(
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

Widget buildNextButton({required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100.w,
      height: 40.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor.withOpacity(0.610), kPrimaryColor],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Next',
            style: GTextStyle.bodyBold.copyWith(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 5.w),
          Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
        ],
      ),
    ),
  );
}
