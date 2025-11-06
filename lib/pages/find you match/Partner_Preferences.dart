import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:agent_porta/widgets/Text_field.dart';
import 'package:agent_porta/widgets/dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

enum imageType { profile, horoscope, idproof }

class PartnerPreferences extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formkey;
  const PartnerPreferences({
    super.key,
    required this.pageController,
    required this.formkey,
  });

  @override
  State<PartnerPreferences> createState() => _PartnerPreferencesState();
}

class _PartnerPreferencesState extends State<PartnerPreferences> {
  final _bioControllar = TextEditingController();
  final _partnerExpectaionControoler = TextEditingController();
  String? _selectedAgeRange;
  String? _selectedHeightRange;
  String? _selectEdupref;
  String? _selectProfession;
  File? _selecthoroscope;

  List<String> ageRangeOptions = [
    "18-25",
    "26-35",
    "36-45",
    "46-55",
    "56-65",
    "65 and above",
  ];
  List<String> heightRangeOptions = [
    "150-160",
    "160-170",
    "170-180",
    "180-190",
    "190-200",
    "200 and above",
  ];
  final List<String> eduPrefOptions = [
    "Doesn't Matter",
    "Degree",
    "Diploma",
    "PG",
  ];
  final List<String> professionOptions = [
    "Doesn't Matter",
    "Engineering",
    "Medical",
    "Arts",
    "Commerce",
  ];
  final List<File?> selectedImages = List.filled(4, null, growable: false);
  final List<File?> iDProofUpload = List.filled(4, null, growable: true);
  final List<File?> othersIdproof = [];

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _imagepicker({
    required ImageSource source,
    required imageType type,
    int? index,
  }) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      if (Platform.isAndroid) {
        final androidinfo = await DeviceInfoPlugin().androidInfo;
        if (androidinfo.version.sdkInt >= 33) {
          status = await Permission.photos.request();
        } else {
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.photos.request();
      }
    }
    if (status.isDenied || status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" permiusiion is requird to pick imagees")),
      );
      return;
    }

    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (picked != null) {
      setState(() {
        File imagefile = File(picked.path);
        switch (type) {
          case imageType.profile:
            if (index != null) {
              selectedImages[index] = imagefile;
            }
            break;

          case imageType.idproof:
            if (index != null) {
              iDProofUpload[index] = imagefile;
            } else {
              iDProofUpload.add(imagefile);
            }
            break;
          case imageType.horoscope:
            _selecthoroscope = File(picked.path);
            break;
        }
      });
    }
  }

  Future<void> _mulitpleimages() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      status = await Permission.photos.request();

      if (status.isDenied) {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    if (status.isDenied || status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("permiusiion is requird to pick imagees")),
      );
    }

    int availableslots = selectedImages.where((slot) => slot == null).length;
    if (availableslots == 0) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("All images Slots Are full. ")));
        return;
      }
    }

    final List<XFile> pickedd = await _picker.pickMultiImage(imageQuality: 85);

    if (pickedd.isEmpty) return;

    setState(() {
      int pikedfileindex = 0;
      int filetoTake = min(availableslots, pickedd.length);

      for (int i = 0; i < selectedImages.length; i++) {
        if (selectedImages[i] == null && pikedfileindex < filetoTake) {
          selectedImages[i] = File(pickedd[pikedfileindex].path);
          pikedfileindex++;
        }
      }

      if (pikedfileindex < pickedd.length) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("not all iamge could be added.Slotes are full"),
            ),
          );
          return;
        }
      }
    });
  }

  void _removeProfileimage(int index) {
    setState(() {
      selectedImages[index] = null;
    });
  }

  void _removeIdproofimage(int index) {
    setState(() {
      iDProofUpload[index] = null;
    });
  }

  @override
  void dispose() {
    _bioControllar.dispose();
    _partnerExpectaionControoler.dispose();
    super.dispose();
  }

  void _onAgeRangeChanged(String? value) {
    setState(() {
      _selectedAgeRange = value;
    });
  }

  void _onHeightRangeChanged(String? value) {
    setState(() {
      _selectedHeightRange = value;
    });
  }

  void _onEduPrefChanged(String? value) {
    setState(() {
      _selectEdupref = value;
    });
  }

  void _onProfessionChanged(String? value) {
    setState(() {
      _selectProfession = value;
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
                "Partner Preferences",
                style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
              ),
              SizedBox(height: 20.h),
              buildDropdown(
                label: "Preferred Age Range *",
                hintText: "Select preferred age range",
                onChanged: _onAgeRangeChanged,
                context: context,
                selectedValue: _selectedAgeRange,
                options: ageRangeOptions,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select preferred age range';
                  }
                  return null;
                },
              ),

              buildDropdown(
                label: "Preferred Height Range *",
                hintText: "Select Preferred Height Range",
                onChanged: _onHeightRangeChanged,
                context: context,
                selectedValue: _selectedHeightRange,
                options: heightRangeOptions,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Height Range';
                  }
                  return null;
                },
              ),

              buildDropdown(
                label: "Education Preference *",
                hintText: "Select Education Preference",
                onChanged: _onEduPrefChanged,
                context: context,
                selectedValue: _selectEdupref,
                options: eduPrefOptions,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Education Preference';
                  }
                  return null;
                },
              ),
              buildDropdown(
                label: "Profession Preference *",
                hintText: "Select Profession Preference",
                onChanged: _onProfessionChanged,
                context: context,
                selectedValue: _selectProfession,
                options: professionOptions,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select  profession preference';
                  }
                  return null;
                },
              ),

              buildimageGrid(
                label: "Profile Photos (1 mandatory, 3 optional)",
                icon: PhosphorIconsFill.upload,
              ),

              builduploadbox(
                context,
                label: "Horoscope (Jadhakam)",
                icon: PhosphorIconsFill.scroll,
              ),

              buildIDProofUpload(
                label: "ID Proof Upload",
                Subtitle1: "Pan Card",
                Subtitle2: "Passport ",
                Subtitle3: "Others",
                icon: PhosphorIconsFill.upload,
              ),

              buildADDField(
                label: "Short Bio / About Me ",
                hintText: "Write a little bit about yourself....",
                Controller: _bioControllar,
                keybordType: TextInputType.multiline,
                icon: PhosphorIconsFill.notePencil,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'please write short bio';
                  }
                  if (value.trim().length > 100) {
                    return "please write least 100 characters. ";
                  }
                  return null;
                },
              ),
              buildADDField(
                label: "Partner Expectation",
                hintText: "Describe what you're Looking for in a partner ....",
                Controller: _partnerExpectaionControoler,
                keybordType: TextInputType.multiline,
                icon: PhosphorIconsFill.userFocus,
                maxlength: 950,
                maxlines: 5,
                minlines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'please describle your expectaion';
                  }
                  if (value.trim().length > 950) {
                    return "please write least 100 characters. ";
                  }
                  return null;
                },
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildNextButton(
                    loading: _isLoading,
                    onTap: () {
                      bool isFormvalid =
                          widget.formkey.currentState?.validate() ?? false;

                      bool mandatroy = selectedImages[0] != null;
                      if (!mandatroy) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please uplod mandatory profile image",
                            ),
                            backgroundColor: kErrorcolor,
                          ),
                        );
                        return;
                      }
                      if (isFormvalid && mandatroy) {
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

  Widget buildIDProofUpload({
    required String? label,
    IconData? icon,
    String? Subtitle,
    dynamic Subtitle1,
    dynamic Subtitle2,
    dynamic Subtitle3,
  }) {
    return Column(
      children: [
        buildFieldLabel(
          label: label ?? "Profile Images",
          icon: icon ?? PhosphorIconsFill.upload,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 100.h,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: kBackgroundColor,
            ),
            child: Row(
              children: [
                SizedBox(width: 10.w),

                Column(
                  children: [
                    Text("Aadhaar", style: GTextStyle.bodySmall),
                    SizedBox(height: 5.h),
                    _imageslotId(0),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    Text(Subtitle1, style: GTextStyle.bodySmall),
                    SizedBox(height: 5.h),

                    _imageslotId(1),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    Text(Subtitle2, style: GTextStyle.bodySmall),
                    SizedBox(height: 5.h),

                    _imageslotId(2),
                  ],
                ),
                SizedBox(width: 10.w),

                // ...List.generate(othersIdproof.length, (index) {
                //   return Column(
                //     children: [
                //       Text("others${index + 1}", style: GTextStyle.bodySmall),
                //       SizedBox(height: 5.h),
                //       _imageslotId(index, isOthers: true),
                //     ],
                //   );
                // }),
                Column(
                  children: [
                    Text(Subtitle3, style: GTextStyle.bodySmall),
                    SizedBox(height: 5.h),
                    _imageslotId(3),

                    // _OthersimageslotId(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildimageGrid({required String? label, IconData? icon}) {
    return Column(
      children: [
        buildFieldLabel(
          label: label ?? "Profile Images",
          icon: icon ?? PhosphorIconsFill.upload,
        ),
        Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: kBackgroundColor,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 10.w),
                _imageslot(0, isPrimary: true),
                SizedBox(width: 10.w),
                _imageslot(1),
                SizedBox(width: 10.w),
                _imageslot(2),
                SizedBox(width: 10.w),
                _imageslot(3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> buildimageSelectSheet(
    BuildContext context,
    imageType type, {
    int? index,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        bool isprofile = (type == imageType.profile);
        bool ishoroscope = (type == imageType.horoscope);
        bool isIdproof = (type == imageType.idproof);
        bool canRemove = false;

        if (isprofile && index != null && selectedImages[index] != null) {
          canRemove = true;
        }
        if (ishoroscope && _selecthoroscope != null) {
          canRemove = true;
        }
        if (isIdproof && index != null && iDProofUpload[index] != null) {
          canRemove = true;
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 3.h),
              Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              ListTile(
                leading: Icon(Icons.camera_alt, color: kPrimaryColor),
                title: Text('Take Photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  _imagepicker(
                    index: index,
                    type: type,

                    source: ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: kPrimaryColor),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  if (isprofile) {
                    _mulitpleimages();
                  } else {
                    _imagepicker(
                      index: index,
                      type: type,
                      source: ImageSource.gallery,
                    );
                  }
                },
              ),

              if (canRemove)
                ListTile(
                  leading: Icon(PhosphorIconsFill.trash, color: kPrimaryColor),
                  title: Text("Remove Image"),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (type == imageType.profile && index != null) {
                      _removeProfileimage(index);
                    } else if (type == imageType.idproof && index != null) {
                      _removeIdproofimage(index);
                    } else if (type == imageType.horoscope) {
                      setState(() {
                        _selecthoroscope = null;
                      });
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _imageslot(int index, {bool isPrimary = false}) {
    final file = selectedImages[index];

    return GestureDetector(
      onTap: () {
        buildimageSelectSheet(context, index: index, imageType.profile);
      },

      child: Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.grey.shade200,
        ),
        child:
            file != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        file,
                        width: double.infinity,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey.shade50, Colors.grey.shade100],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        isPrimary
                            ? Icons.camera_alt
                            : Icons.add_a_photo_rounded,
                        size: 20,
                        color: isPrimary ? kPrimaryColor : Colors.grey,
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        isPrimary ? "mandatory" : "Optional",
                        style: GTextStyle.bodyMedium.copyWith(
                          fontSize: isPrimary ? 14 : 12,
                          color: isPrimary ? kPrimaryColor : Colors.grey,
                          fontWeight: isPrimary ? FontWeight.w600 : null,
                        ),
                      ),
                      // if (isPrimary) Text("Tap to add upload"),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _imageslotId(int index, {bool isOthers = false}) {
    final file = isOthers ? othersIdproof[index] : iDProofUpload[index];

    return GestureDetector(
      onTap: () {
        buildimageSelectSheet(context, index: index, imageType.idproof);
      },

      child: Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.grey.shade200,
        ),
        child:
            file != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        file,
                        width: double.infinity,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey.shade50, Colors.grey.shade100],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.h),

                      Text("Upload", style: GTextStyle.bodySmall),
                    ],
                  ),
                ),
      ),
    );
  }

  // Widget _OthersimageslotId() {
  //   return GestureDetector(
  //     onTap: () {
  //       buildimageSelectSheet(
  //         context,
  //         index: othersIdproof.length - 1,
  //         imageType.idproof,
  //       );
  //       setState(() {
  //         othersIdproof.add(null);
  //       });
  //     },

  //     child: Container(
  //       height: 80.h,
  //       width: 80.w,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8.r),
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [Colors.grey.shade50, Colors.grey.shade100],
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(Icons.add_a_photo_rounded, size: 20, color: Colors.grey),
  //           SizedBox(height: 8.h),

  //           Text("Upload", style: GTextStyle.bodySmall),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget builduploadbox(
    BuildContext context, {
    required String? label,
    IconData? icon,
  }) {
    final file = _selecthoroscope;
    return InkWell(
      onTap: () {
        buildimageSelectSheet(context, imageType.horoscope);
      },
      child: Column(
        children: [
          buildFieldLabel(
            label: label ?? "",
            icon: icon ?? PhosphorIconsFill.scroll,
          ),
          SizedBox(height: 8.h),
          file == null
              ? DottedBorder(
                strokeCap: StrokeCap.round,
                color: kPrimaryColor,
                strokeWidth: 2,
                dashPattern: [8, 6],
                radius: Radius.circular(10.r),
                padding: EdgeInsets.symmetric(horizontal: 2.w),

                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100]!,
                    borderRadius: BorderRadius.circular(8.r),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.upload_file, size: 30, color: kPrimaryColor),
                      SizedBox(height: 10.h),
                      Text("upload horoscope ", style: GTextStyle.bodyMedium),
                      SizedBox(height: 6.h),
                      Text(
                        "Tap to select a (Jadhakam) photo",
                        style: GTextStyle.bodyMedium.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100]!,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            file,
                            height: 150.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
