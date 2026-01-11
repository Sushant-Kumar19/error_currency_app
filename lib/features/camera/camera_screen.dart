import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../missions/mission_model.dart';
import '../recognition/recognition_screen.dart';

class CameraScreen extends StatefulWidget {
  final Mission mission;

  CameraScreen({required this.mission});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RecognitionScreen(
            imageFile: _image!,
            mission: widget.mission,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pickImage(); // Open camera immediately
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mission.title)),
      body: Center(
        child: _image == null ? Text('Opening camera...') : Image.file(_image!),
      ),
    );
  }
}
