import 'dart:convert';
import 'dart:io';
import '../../providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// import '../wallet/wallet.dart';

import 'mission_model.dart';

class MissionCameraScreen extends StatefulWidget {
  final Mission mission;

  MissionCameraScreen({required this.mission});

  @override
  State<MissionCameraScreen> createState() => _MissionCameraScreenState();
}

class _MissionCameraScreenState extends State<MissionCameraScreen> {
  File? _image;
  bool _loading = false;

  // ⚠️ Replace with your Imagga credentials
  final String apiKey = 'acc_32e9103db520cc9';
  final String apiSecret = 'c3d088a9742666905025eb69a6359ddd';

  final ImagePicker _picker = ImagePicker();

  // ------------------------
  // Capture Image from Camera
  // ------------------------
  Future<void> _captureImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() => _image = File(picked.path));
      await _validateImage();
    }
  }

  // ------------------------
  // Validate Image with Imagga
  // ------------------------
  Future<void> _validateImage() async {
    if (_image == null) return;

    setState(() => _loading = true);

    final basicAuth = base64Encode(utf8.encode('$apiKey:$apiSecret'));

    try {
      // 1️⃣ Upload image
      var uploadReq = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.imagga.com/v2/uploads'),
      );

      uploadReq.headers['Authorization'] = 'Basic $basicAuth';
      uploadReq.files.add(
        await http.MultipartFile.fromPath('image', _image!.path),
      );

      var uploadRes = await uploadReq.send();
      var uploadBody = await uploadRes.stream.bytesToString();

      print('Upload Response: $uploadBody');

      final uploadJson = jsonDecode(uploadBody);

      if (uploadJson['result'] == null ||
          uploadJson['result']['upload_id'] == null) {
        // ❌ Upload failed, try test URL fallback
        print('Upload failed, trying fallback URL');
        await _validateWithTestUrl(basicAuth);
        return;
      }

      final uploadId = uploadJson['result']['upload_id'];

      // 2️⃣ Get tags
      final tagRes = await http.get(
        Uri.parse('https://api.imagga.com/v2/tags?image_upload_id=$uploadId'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      print('Tag Response: ${tagRes.body}');

      final tagJson = jsonDecode(tagRes.body);

      if (tagJson['result'] == null || tagJson['result']['tags'] == null) {
        _showErrorDialog('Failed to analyze image. Please try again.');
        return;
      }

      final List tags = tagJson['result']['tags'];

      List<String> obtainedTags = tags
          .map<String>((t) => t['tag']?['en']?.toString().toLowerCase() ?? '')
          .where((tag) => tag.isNotEmpty)
          .toList();

      print('Obtained Tags: $obtainedTags');

      _processValidation(obtainedTags);
    } catch (e) {
      _showErrorDialog(
          'Something went wrong. Please check your network or API key.');
    } finally {
      setState(() => _loading = false);
    }
  }

  // ------------------------
  // Fallback for testing: URL instead of upload
  // ------------------------
  Future<void> _validateWithTestUrl(String basicAuth) async {
    try {
      // Using a test image from Imagga site
      final testImageUrl =
          'https://imagga.com/static/images/tagging/wind-farm-538576_640.jpg';

      final tagRes = await http.get(
        Uri.parse('https://api.imagga.com/v2/tags?image_url=$testImageUrl'),
        headers: {'Authorization': 'Basic $basicAuth'},
      );

      print('Fallback Tag Response: ${tagRes.body}');

      final tagJson = jsonDecode(tagRes.body);

      if (tagJson['result'] == null || tagJson['result']['tags'] == null) {
        _showErrorDialog('Fallback analysis failed. Check API key.');
        return;
      }

      final List tags = tagJson['result']['tags'];

      List<String> obtainedTags = tags
          .map<String>((t) => t['tag']?['en']?.toString().toLowerCase() ?? '')
          .where((tag) => tag.isNotEmpty)
          .toList();

      print('Fallback Obtained Tags: $obtainedTags');

      _processValidation(obtainedTags);
    } catch (e) {
      _showErrorDialog('Fallback validation failed: ${e.toString()}');
    }
  }

  // ------------------------
  // Process Validation Result
  // ------------------------
  void _processValidation(List<String> obtainedTags) {
    bool isValid = widget.mission.validTags.any(
      (tag) => obtainedTags.contains(tag.toLowerCase()),
    );

    if (isValid) {
      if (!widget.mission.isCompleted) {
        widget.mission.isCompleted = true;
        // ✅ Pass both points and mission
        UserProvider.addPoints(widget.mission.rewardPoints, widget.mission);
      }

      final matchedTag = widget.mission.validTags.firstWhere(
        (tag) => obtainedTags.contains(tag.toLowerCase()),
      );

      _showResultDialog(success: true, matchedTag: matchedTag);
    } else {
      _showResultDialog(success: false);
    }
  }

  // ------------------------
  // Show Result Dialog
  // ------------------------
  void _showResultDialog({required bool success, String? matchedTag}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(success ? '✅ Image Validated' : '❌ Invalid Image'),
        content: Text(
          success
              ? 'Matched Tag: $matchedTag\n\nYou earned 🪙 ${widget.mission.rewardPoints}'
              : 'No valid object found for this mission.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              if (success)
                Navigator.pop(context, true); // return to mission list
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // ------------------------
  // Show Error Dialog
  // ------------------------
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('⚠️ Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // ------------------------
  // Build UI
  // ------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📸 ${widget.mission.title}')),
      body: Center(
        child: _loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Validating image...'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_image != null) Image.file(_image!, height: 250),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _captureImage,
                    child: Text('📸 Capture Image'),
                  ),
                ],
              ),
      ),
    );
  }
}
