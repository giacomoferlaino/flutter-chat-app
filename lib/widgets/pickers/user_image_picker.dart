import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickedImage =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.camera),
          label: const Text('Add image'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
