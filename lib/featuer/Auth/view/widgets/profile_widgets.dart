import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  static String? selectedImagePath; // مهم

  final double radius;
  final Color backgroundColor;
  final Color iconColor;

  const AvatarPicker({
    super.key,
    required this.radius,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // pick image
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          AvatarPicker.selectedImagePath = image.path;
          setState(() {});
        }
      },
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: widget.backgroundColor,
        backgroundImage: AvatarPicker.selectedImagePath != null
            ? FileImage(File(AvatarPicker.selectedImagePath!))
            : null,
        child: AvatarPicker.selectedImagePath == null
            ? Icon(Icons.camera_alt, color: widget.iconColor)
            : null,
      ),
    );
  }
}
