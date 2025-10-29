import 'dart:io';

import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/styles/theme_helper.dart';
import 'package:agent_porta/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uicons/uicons.dart';
import '../styles/constants.dart';
import '../widgets/custom_listTile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddCustomerPage(),
    );
  }
}

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _businessNameFocus = FocusNode();
  final FocusNode _ownerFocus = FocusNode();
  final FocusNode _departmentFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _gstFocus = FocusNode();
  final FocusNode _aadhaarFocus = FocusNode();
  final FocusNode _uploadFocus = FocusNode();
  final FocusNode _qrFocus = FocusNode();

  int? selectedTile ;

  String _paymentMethod = 'Offline';
  bool showQr = false;


  final int _minFiles = 3;
  List<File> _uploadedFiles = []; // Store selected files

  void _onFilesSelected(List<File> files) {
    setState(() {
      _uploadedFiles = files;
    });
  }

  void _submitForm() {
    // Perform form submission logic (API call, database update, etc.)

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Form submitted successfully.",style: GTextStyle.bodyBold.copyWith(fontSize: 10,letterSpacing: 1)),
        backgroundColor: kPrimaryColor,
      ),
    );

    // Clear all input fields
    _clearFields();
  }

  void _clearFields() {
    _formKey.currentState!.reset(); // Reset form fields
    setState(() {
      _uploadedFiles.clear(); // Clear selected images
      selectedTile = null;
      _paymentMethod = 'Offline'; // Reset payment method
    });
  }

  List<File> _selectedFiles = [];
  final int _maxFiles = 10;
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
                'Select Images',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'nunito',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  InkWell(
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
                            Icons.camera_alt,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gallery option
                  InkWell(
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
                            Icons.photo_library,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 14,
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
      List<File> newFiles = pickedFiles.take(remainingSlots).map((file) => File(file.path)).toList();

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

    _businessNameFocus.addListener(() {
      setState(() {
        selectedTile = _businessNameFocus.hasFocus ? 0 : null;
      });
    });

    _ownerFocus.addListener(() {
      setState(() {
        selectedTile = _ownerFocus.hasFocus ? 1 : null;
      });
    });

    _departmentFocus.addListener(() {
      setState(() {
        selectedTile = _departmentFocus.hasFocus ? 2 : null;
      });
    });

    _locationFocus.addListener(() {
      setState(() {
        selectedTile = _locationFocus.hasFocus ? 3: null;
      });
    });

    _emailFocus.addListener(() {
      setState(() {
        selectedTile = _emailFocus.hasFocus ? 4 : null;
      });
    });

    _phoneFocus.addListener(() {
      setState(() {
        selectedTile = _phoneFocus.hasFocus ? 5 : null;
      });
    });

    _gstFocus.addListener(() {
      setState(() {
        selectedTile = _gstFocus.hasFocus ? 6 : null;
      });
    });

    _aadhaarFocus.addListener(() {
      setState(() {
        selectedTile = _aadhaarFocus.hasFocus ? 7 : null;
      });
    });

    _uploadFocus.addListener(() {
      setState(() {
        selectedTile = _uploadFocus.hasFocus ? 8 : null;
      });
    });

    _qrFocus.addListener(() {
      setState(() {
        selectedTile = _qrFocus.hasFocus ? 9 : null;
      });
    });

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
        title: Text('Add Business', style: GTextStyle.bodyBold.copyWith(fontSize: 18,fontWeight: FontWeight.w800)),
        titleSpacing: 30,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        leading: IconButton(
            onPressed: (){ Navigator.pop(context); },
            icon: Icon(UIcons.solidRounded.angle_left,size: 15,)
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20),
                      // Text(
                      //   "Add Business",
                      //   style: GTextStyle.heading1Medium.copyWith(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                      //SizedBox(height: 30),
                      CustomListTile(
                        title: "Business Name",
                        hintText: "Enter business name",
                        focusNode: _businessNameFocus,
                        isSelected: selectedTile == 0,
                        onTap: () => _businessNameFocus.requestFocus(),
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.buildings,
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty ? "Business name is required" : null,
                      ),

                      const SizedBox(height: 15),
                      CustomListTile(
                        title: "Owner Name",
                        hintText: "Enter Owner name",
                        focusNode: _ownerFocus,
                        isSelected: selectedTile == 1,
                        onTap: () => _ownerFocus.requestFocus(),
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.userCircle,
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty ? "Owner name is required" : null,
                      ),

                      const SizedBox(height: 15),

                      // Department Field
                      CustomListTile(
                        title: "Department",
                        hintText: "Enter department",
                        focusNode: _departmentFocus,
                        isSelected: selectedTile == 2,
                        onTap: () => _departmentFocus.requestFocus(),
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.briefcase,
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty ? "Department is required" : null,
                      ),

                      const SizedBox(height: 15),

                      // Location Field
                      CustomListTile(
                        title: "Location",
                        hintText: "Enter location",
                        focusNode: _locationFocus,
                        isSelected: selectedTile == 3,
                        onTap: () => _locationFocus.requestFocus(),
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.mapPinArea,
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty ? "Location is required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomListTile(
                        title: "Email",
                        hintText: "Enter Email",
                        focusNode: _emailFocus,
                        isSelected: selectedTile == 4,
                        onTap: ()=> _emailFocus.requestFocus(),
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.envelope,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                              .hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomListTile(
                        title: "Phone Number",
                        hintText: "Enter phone number",
                        focusNode: _phoneFocus,
                        isSelected: selectedTile == 5,
                        onTap: () => _phoneFocus.requestFocus(),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required";
                          }
                          if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                            return "Enter a valid 10-digit phone number";
                          }
                          return null;
                        },
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: UIcons.regularRounded .mobile_notch,
                      ),
                      SizedBox(height: 15),
                      CustomListTile(
                        title: "Gst no",
                        hintText: "Enter Gst no",
                        focusNode: _gstFocus,
                        isSelected: selectedTile == 6,
                        onTap: () => _gstFocus.requestFocus(),
                        keyboardType: TextInputType.text,
                        //validator: (value) => value!.isEmpty ? "GST No is required" : null,
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.dotsThree,
                      ),
                      SizedBox(height: 15),
                      CustomListTile(
                        title: "Aadhaar No",
                        hintText: "Enter Aadhaar number",
                        focusNode: _aadhaarFocus,
                        isSelected: selectedTile == 7,
                        onTap: () => _aadhaarFocus.requestFocus(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Aadhaar number is required";
                          }
                          if (!RegExp(r"^\d{12}$").hasMatch(value)) {
                            return "Enter a valid 12-digit Aadhaar number";
                          }
                          return null;
                        },
                        //tileColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        icon: PhosphorIconsFill.creditCard,
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: _pickFiles,
                        child: Container(
                          //height: 120,
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Upload Picture ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: kPrimaryColor),),
                                  Icon(PhosphorIconsFill.upload,size: 18,color: kPrimaryColor,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              _selectedFiles.isEmpty
                                  ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Ionicons.image, size: 40, color: Colors.black38),
                                      SizedBox(height: 8),
                                      Text(
                                        'Tap to capture or upload pictures',
                                        style: TextStyle(fontFamily: 'qs', fontWeight: FontWeight.w500, color: Colors.grey,fontSize: 12),
                                      ),
                                      Text(
                                        'Min: $_minFiles, Max: $_maxFiles files',
                                        style: TextStyle(fontFamily: 'qs', fontSize: 11, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(10,0,5,5),
                                child: Row(
                                  children: _selectedFiles.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    File file = entry.value;
                                    return Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
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
                                              onTap: () => _removeFile(index),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius: BorderRadius.circular(10),
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
                            ],
                          ),
                        ),
                      ),

                      if (_selectedFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 10),
                          child: Text(
                            '${_selectedFiles.length} file(s) selected',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontFamily: 'qs',
                            ),
                          ),
                        ),
                      SizedBox(height: 15,),
                      // CustomListTile(
                      //   titlewidget: Center(
                      //     child: Text(
                      //       'Payment',
                      //       style: GTextStyle.bodyBold.copyWith(
                      //         fontSize: 12,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     setState(() {
                      //       showQr = !showQr; // Toggle QR visibility
                      //       selectedTile = 9; // Set selected tile index
                      //     });
                      //   },
                      //   isSelected: selectedTile == 9, // Make it react visually like other fields
                      //   subtitle: showQr
                      //       ? Center(
                      //     child: QrImageView(
                      //       data:
                      //       'upi://pay?pa=jafzshami@oksbi&pn=Jafz Shami&tn=TestPayment&am=1.00&cu=INR',
                      //       version: QrVersions.auto,
                      //       size: 140.0,
                      //     ),
                      //   )
                      //       : Center(
                      //       child: Text('Just click',style: GTextStyle.bodyBold.copyWith(
                      //         fontSize: 12,
                      //         color: Colors.grey,
                      //         fontWeight: FontWeight.w600,
                      //       ),)
                      //   ),
                      //   contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      // ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        color: Colors.white,
                        child: Container(
                          height: 50,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), // Soft shadow
                                offset: Offset(0, 0), // x, y
                                blurRadius: 8,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_uploadedFiles.length < 3) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please upload at least 3 images.",
                                        style: GTextStyle.bodyBold.copyWith(fontSize: 10, letterSpacing: 1),
                                      ),
                                      backgroundColor: kPrimaryColor,
                                    ),
                                  );
                                  return;
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Center(child: Text("Confirm Submission", style: GTextStyle.bodyBold.copyWith(fontSize: 16))),
                                    content: Text("Are you sure you want to submit the form?", style: GTextStyle.bodyBold.copyWith(fontSize: 12)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ThemeHelper().buttonStyle_alert(forgColor: kPrimaryColor, backColor: Colors.white),
                                        child: Text("Cancel", style: GTextStyle.bodyBold.copyWith(fontSize: 10)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _submitForm();
                                        },
                                        style: ThemeHelper().buttonStyle_alert(),
                                        child: Text("OK", style: GTextStyle.bodyBold.copyWith(fontSize: 10)),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Add',
                                style: GTextStyle.bodyBold.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white, // ensure contrast
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
