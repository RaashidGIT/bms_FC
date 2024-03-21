// The code necessary for the photo capturing of special_user via device camera

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SpImagePicker extends StatefulWidget {
  const SpImagePicker({
    super.key,
    required this.onPickImage,
    this.imageQuality = 80,
    this.maxWidth = 300,
  });

  final void Function(File? pickedImage) onPickImage; // Allow null for handling errors
  final int imageQuality;
  final int maxWidth;

  @override
  State<SpImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<SpImagePicker> {
  File? _pickedImageFile;

  Future<void> getImage() async {
    try {
      bool? isCamera = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Camera"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Gallery"),
              ),
            ],
          ),
        ),
      );

      if (isCamera == null) return;

      await _pickImage(isCamera: isCamera!);
    } catch (error) {
      // Handling any error, e.g., showing a snackbar
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error picking image: $error"),
        ),
      );
    }
  }

  Future<void> _pickImage({required bool isCamera}) async {
    final pickedImage = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) return;

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : null,
        ),
        TextButton.icon(
          onPressed: getImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}