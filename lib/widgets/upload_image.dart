import 'package:agent_porta/styles/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../styles/style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UploadImageTile extends StatefulWidget {
  final Color? titleColor;
  final bool isSelected;
  final Function(List<File>)? onFilesSelected; // Callback to notify the parent

  const UploadImageTile({
    Key? key,
    this.titleColor,
    this.isSelected = false,
    this.onFilesSelected,
  }) : super(key: key);

  @override
  _UploadImageTileState createState() => _UploadImageTileState();
}

class _UploadImageTileState extends State<UploadImageTile> {
  List<File> _selectedFiles = [];
  final int _maxFiles = 10;
  final int _minFiles = 3;

  Future<void> _pickFiles() async {
    if (_selectedFiles.length >= _maxFiles) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You can only select up to $_maxFiles files',
            style: GTextStyle.bodyBold.copyWith(fontSize: 12, letterSpacing: 1),
          ),
          backgroundColor: kPrimaryColor,
        ),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf', 'svg'],
      allowMultiple: true,
    );

    if (result != null) {
      int remainingSlots = _maxFiles - _selectedFiles.length;
      List<File> newFiles =
          result.files
              .take(remainingSlots)
              .map((file) => File(file.path!))
              .toList();

      if (newFiles.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(newFiles);
        });
        widget.onFilesSelected?.call(_selectedFiles); // Notify parent
      }

      if (result.files.length > remainingSlots) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You can only select up to $_maxFiles files. ${result.files.length - remainingSlots} files were ignored.',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            backgroundColor: kPrimaryColor,
          ),
        );
      }
    }
  }

  List<File> get selectedFiles => _selectedFiles;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _pickFiles,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Upload Files (${_selectedFiles.length}/$_maxFiles)",
          style: GTextStyle.bodyBold.copyWith(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: widget.isSelected ? widget.titleColor : Colors.black,
          ),
        ),
      ),
      subtitle:
          _selectedFiles.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 2.0,
                    runSpacing: 0,
                    children:
                        _selectedFiles.map((file) {
                          String extension =
                              file.path.split('.').last.toLowerCase();

                          if ([
                            'png',
                            'jpg',
                            'jpeg',
                            'svg',
                          ].contains(extension)) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                file,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.r),
                                  Text(
                                    file.path.split('/').last,
                                    style: GTextStyle.bodySmall.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }
                        }).toList(),
                  ),
                ],
              )
              : Text(
                "Please upload at least $_minFiles images",
                style: GTextStyle.bodyBold.copyWith(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
      tileColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      trailing: IconButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size.square(1)),
        ),
        icon: const Icon(
          PhosphorIconsFill.upload,
          color: Colors.grey,
          size: 20,
        ),
        onPressed: _pickFiles,
      ),
    );
  }
}
