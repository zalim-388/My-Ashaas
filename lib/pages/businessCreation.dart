import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_ashaas/styles/constants.dart';
import 'package:my_ashaas/widgets/Text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';
import '../styles/style.dart';
import 'home_page.dart';

class businessCreation extends StatefulWidget {
  const businessCreation({super.key});

  @override
  State<businessCreation> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<businessCreation> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _gstNumberController = TextEditingController();
  final _aadhaarNumberController = TextEditingController();
  final _nomineeController = TextEditingController();
  final _nomineeNumberController = TextEditingController();

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
            style: GTextStyle.bodySmall.copyWith(color: Colors.white),
          ),
          backgroundColor: kBlackPrimary,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: kBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
          height: 200.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select Pictures',
                textAlign: TextAlign.center,
                style: GTextStyle.body,
              ),
              SizedBox(height: 20.h),
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
                          radius: 30.r,
                          backgroundColor: kPrimaryColor.withOpacity(.1),
                          child: Icon(
                            Ionicons.camera,
                            size: 25.spMin,
                            color: kBlackPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text('Camera', style: GTextStyle.bodySmall.copyWith()),
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
                          radius: 30.r,
                          backgroundColor: kPrimaryColor.withOpacity(.1),
                          child: Icon(
                            Ionicons.images,
                            size: 25.spMin,
                            color: kBlackPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text('Gallery', style: GTextStyle.bodySmall.copyWith()),
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
          content: Text(
            'Maximum $_maxFiles files allowed',
            style: GTextStyle.bodySmall.copyWith(color: Colors.white),
          ),
          backgroundColor: kBlackPrimary,
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
          content: Text(
            'Maximum $_maxFiles files allowed',
            style: GTextStyle.bodySmall.copyWith(color: Colors.white),
          ),
          backgroundColor: kBlackPrimary,
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
              style: GTextStyle.bodySmall.copyWith(color: Colors.white),
            ),
            backgroundColor: kBlackPrimary,
          ),
        );
      }
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
    _nameController.dispose();
    _lastNameController.dispose();
    _departmentController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _locationController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _gstNumberController.dispose();
    _aadhaarNumberController.dispose();
    _nomineeController.dispose();
    _nomineeNumberController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedFiles.length < _minFiles) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload at least $_minFiles images')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final token =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4MGU4MjM4ODA5NWIzYmEwOTFiNDBkNSIsInBob25lIjoiNjIzODk4NDE3NyIsImlhdCI6MTc0NjUzMDkwMCwiZXhwIjoxNzQ3MTM1NzAwfQ.R0R6KfWb-3yYgGepJ2mimfDaQeUZHUwewrzra8-Ok7Y';

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://empgold.online/create-business'),
        );

        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Accept'] = 'application/json';

        // Add text fields
        request.fields['businessName'] = _nameController.text;
        request.fields['ownerName'] = _lastNameController.text;
        request.fields['department'] = _departmentController.text;
        request.fields['email'] = _emailController.text;
        request.fields['contactNumber'] = _contactNumberController.text;
        request.fields['location'] = _locationController.text;
        request.fields['district'] = _districtController.text;
        request.fields['state'] = _stateController.text;
        request.fields['country'] = _countryController.text;
        request.fields['gstNumber'] = _gstNumberController.text;
        request.fields['aadhaarNumber'] = _aadhaarNumberController.text;
        request.fields['nominee'] = _nomineeController.text;
        request.fields['nomineeNumber'] = _nomineeNumberController.text;

        // Add multiple image files
        for (int i = 0; i < _selectedFiles.length; i++) {
          request.files.add(
            await http.MultipartFile.fromPath('images', _selectedFiles[i].path),
          );
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200 || response.statusCode == 201) {
          try {
            json.decode(response.body);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('✅ Business created successfully')),
            );
            Navigator.pop(context);
          } catch (jsonError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✅ Success, but response format was unexpected'),
              ),
            );
            Navigator.pop(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Error: HTTP ${response.statusCode}')),
          );
        }
      } catch (err) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Error: ${err.toString()}')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text('Add Business', style: GTextStyle.heading2Bold.copyWith()),
        titleSpacing: 30.w,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15.w),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(
            UIcons.solidRounded.angle_left,
            size: 18.spMin,
            color: kArrowBackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Business Name',
                  icon: PhosphorIconsFill.buildings,
                  hintText: 'Enter Business Name',
                  Controller: _nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Business name';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Owner Name',
                  icon: PhosphorIconsFill.userCircle,
                  hintText: 'Enter owner Name',
                  Controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter owner name';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Department',
                  icon: PhosphorIconsFill.suitcase,
                  hintText: 'Enter Department',
                  Controller: _departmentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter department';
                    }
                    return null;
                  },
                ),
                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Email Id',
                  icon: PhosphorIconsFill.envelope,
                  hintText: 'Enter Email Id',
                  Controller: _emailController,
                  keybordType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Mobile Number',
                  icon: UIcons.regularRounded.mobile_notch,
                  hintText: 'Enter 10 digit mobile number',
                  keybordType: TextInputType.phone,

                  Controller: _contactNumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter mobile number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Location',
                  icon: PhosphorIconsFill.mapPinArea,
                  hintText: 'Enter Location',
                  Controller: _locationController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Location';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'District',
                  icon: PhosphorIconsFill.mapPin,

                  hintText: 'Enter district',
                  Controller: _districtController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter district';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'State',
                  icon: PhosphorIconsFill.globeStand,
                  hintText: 'Enter state',
                  Controller: _stateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter state';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Country',
                  icon: PhosphorIconsFill.globeHemisphereEast,
                  hintText: 'Enter country',
                  Controller: _countryController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter country';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'GST Number',
                  icon: PhosphorIconsFill.pencilSimpleLine,
                  hintText: 'Enter GST number',
                  Controller: _gstNumberController,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(
                          r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
                        ).hasMatch(value)) {
                      return 'Invalid GST format';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,

                  context: context,
                  label: 'Aadhaar Number',
                  icon: PhosphorIconsFill.creditCard,
                  hintText: 'Enter Aadhaar number',
                  Controller: _aadhaarNumberController,
                  keybordType: TextInputType.number,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                      return 'Invalid Aadhaar format';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Nominee Name',
                  icon: PhosphorIconsFill.userCircle,
                  hintText: 'Enter nominee Name',
                  Controller: _nomineeController,
                  keybordType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter nominee name';
                    }
                    return null;
                  },
                ),

                buildADDField(
                  showBorderside: true,
                  context: context,
                  label: 'Nominee Number',
                  icon: PhosphorIconsRegular.numpad,
                  hintText: 'Enter nominee 10 digit mobile number',
                  Controller: _nomineeNumberController,
                  keybordType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter nominee mobile number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                buildFieldLabel(
                  label: 'Upload Pictures (Min: $_minFiles, Max: $_maxFiles)',
                  icon: PhosphorIconsFill.upload,
                  context: context,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: _pickFiles,
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kTextFieldBorder,
                        width: isLandscape ? 0.5.w : 1.w,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: kBackgroundColor,
                    ),
                    child:
                        _selectedFiles.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.image,
                                    size: 40.spMin,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Tap to capture or upload pictures',
                                    style: GTextStyle.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: kTextPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Min: $_minFiles, Max: $_maxFiles files',
                                    style: GTextStyle.bodyMedium.copyWith(
                                      color: kTextPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(15.w, 0, 5.w, 0),
                                child: Row(
                                  children:
                                      _selectedFiles.asMap().entries.map((
                                        entry,
                                      ) {
                                        int index = entry.key;
                                        File file = entry.value;
                                        return Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child: Image.file(
                                                  file,
                                                  width:
                                                      isLandscape ? 60.w : 80.w,
                                                  height: 80.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 4.h,
                                                right: 3.w,
                                                child: GestureDetector(
                                                  onTap:
                                                      () => _removeFile(index),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                      5.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.r,
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      Ionicons.trash_outline,
                                                      color: Colors.white,
                                                      size: 14.spMin,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                  ),
                ),

                if (_selectedFiles.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, left: 10.w),
                    child: Text(
                      '${_selectedFiles.length} file(s) selected',
                      style: GTextStyle.bodyMedium.copyWith(
                        color: kTextPrimary,
                      ),
                    ),
                  ),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: _isLoading ? null : _submitForm,

                  child: Container(
                    height: 45.h,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kBottomNavBarSelected.withOpacity(0.65),
                          kBottomNavBarSelected,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.9],
                        tileMode: TileMode.decal,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child:
                        _isLoading
                            ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.w,
                              ),
                            )
                            : Text(
                              'SUBMIT',
                              style: GTextStyle.button.copyWith(
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),

                SizedBox(height: isLandscape ? 20.h : 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
