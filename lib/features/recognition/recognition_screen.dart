import 'dart:io';
import 'package:flutter/material.dart';
import 'imagga_service.dart';
import '../../models/tag_model.dart';
import '../missions/mission_model.dart';
import '../../providers/user_provider.dart';

class RecognitionScreen extends StatefulWidget {
  final File imageFile;
  final Mission mission;

  RecognitionScreen({required this.imageFile, required this.mission});

  @override
  _RecognitionScreenState createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  // bool _loading = true;

  @override
  void initState() {
    super.initState();
    _recognize();
  }

  Future<void> _recognize() async {
    List<Tag> tags = await ImaggaService.recognizeImage(widget.imageFile);

    bool matched = tags.any(
      (tag) => tag.tag.toLowerCase() == widget.mission.requiredTag,
    );

    if (matched) {
      UserProvider.addPoints(widget.mission.rewardPoints, widget.mission);
    }

    _showResult(matched);
  }

  void _showResult(bool matched) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(matched ? '✅ Mission Completed' : '❌ Mission Failed'),
        content: Text(
          matched
              ? 'You earned ${widget.mission.rewardPoints} points!'
              : 'Required object not detected.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
