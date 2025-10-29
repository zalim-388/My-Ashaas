import 'dart:convert';
import 'dart:io';
import 'package:agent_porta/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

import '../styles/style.dart';
import 'home_page.dart';

void main() {
  runApp(const businessCreation());
}

class businessCreation extends StatelessWidget {
  const businessCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 11,
            fontFamily: 'qs',
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 11,
            fontFamily: 'qs',
          ),
          errorStyle: TextStyle(
            color: kPrimaryColor.withOpacity(.7),
            fontWeight: FontWeight.w500,
            fontSize: 11,
            fontFamily: 'qs',
          ),
          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
          isDense: true,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'qs',
          ),
        ),
      ),
      home: const ContactFormScreen(),
    );
  }
}

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
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
          height: 200,
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
                          style: TextStyle(fontFamily: 'qs', fontSize: 14,fontWeight: FontWeight.w600),
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
                          style: TextStyle(fontFamily: 'qs', fontSize: 14,fontWeight: FontWeight.w600),
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
            final result = json.decode(response.body);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Business',
          style: GTextStyle.bodyBold.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        titleSpacing: 30,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(UIcons.solidRounded.angle_left, size: 15),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFieldLabel(
                  label: 'Business Name',
                  icon: PhosphorIconsFill.buildings,
                  topPad: 5
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Business Name',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter Business name'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'Owner Name',
                  icon: PhosphorIconsFill.userCircle,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter owner Name',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter owner name'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'Department',
                  icon: PhosphorIconsFill.suitcase,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Department',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter department';
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'Email Id',
                  icon: PhosphorIconsFill.envelope,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Enter Email Id'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter email';
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'Mobile Number',
                  icon: UIcons.regularRounded.mobile_notch,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _contactNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter 10 digit mobile number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter mobile number';
                    if (!RegExp(r'^\d{10}$').hasMatch(value))
                      return 'Invalid mobile number';
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'Location',
                  icon: PhosphorIconsFill.mapPinArea,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _locationController,
                  decoration: const InputDecoration(hintText: 'Enter Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter Location';
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'District',
                  icon: PhosphorIconsFill.mapPin,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _districtController,
                  decoration: const InputDecoration(hintText: 'Enter district'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter district'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'State',
                  icon: PhosphorIconsFill.globeStand,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _stateController,
                  decoration: const InputDecoration(hintText: 'Enter state'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter state'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'Country',
                  icon: PhosphorIconsFill.globeHemisphereEast,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _countryController,
                  readOnly: true,
                  decoration: const InputDecoration(hintText: 'Enter country'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter country'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'GST Number',
                  icon: PhosphorIconsFill.pencilSimpleLine,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _gstNumberController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'Enter GST number',
                  ),
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

                _buildFieldLabel(
                  label: 'Aadhaar Number',
                  icon: PhosphorIconsFill.creditCard,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _aadhaarNumberController,
                  decoration: InputDecoration(hintText: 'Enter Aadhaar number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                      return 'Invalid Aadhaar format';
                    }
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'Nominee Name',
                  icon: PhosphorIconsFill.userCircle,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _nomineeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter nominee Name',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter nominee name'
                              : null,
                ),

                _buildFieldLabel(
                  label: 'Nominee Number',
                  icon: PhosphorIconsRegular.numpad,
                ),
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _nomineeNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter nominee 10 digit mobile number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter nominee mobile number';
                    if (!RegExp(r'^\d{10}$').hasMatch(value))
                      return 'Invalid mobile number';
                    return null;
                  },
                ),

                _buildFieldLabel(
                  label: 'Upload Pictures (Min: $_minFiles, Max: $_maxFiles)',
                  icon: PhosphorIconsFill.upload,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: _pickFiles,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child:
                        _selectedFiles.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.image,
                                    size: 40,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tap to capture or upload pictures',
                                    style: TextStyle(
                                      fontFamily: 'qs',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Min: $_minFiles, Max: $_maxFiles files',
                                    style: TextStyle(
                                      fontFamily: 'qs',
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                child: Row(
                                  children:
                                      _selectedFiles.asMap().entries.map((
                                        entry,
                                      ) {
                                        int index = entry.key;
                                        File file = entry.value;
                                        return Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  file,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap:
                                                      () => _removeFile(index),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      Ionicons.trash_outline,
                                                      color: Colors.white,
                                                      size: 14,
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
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Text(
                      '${_selectedFiles.length} file(s) selected',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'qs',
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.transparent, // Set to transparent
                    shadowColor: Colors.transparent, // Optional: removes button shadow
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor.withOpacity(0.65),
                          kPrimaryColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.9],
                        tileMode: TileMode.decal,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 50),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'qs',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel({required String label, IconData? icon, double? topPad}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0, left: 10, right: 5, top: topPad ?? 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontFamily: 'qs',
            ),
          ),
          Icon(icon, size: 18, color: kPrimaryColor),
        ],
      ),
    );
  }
}
