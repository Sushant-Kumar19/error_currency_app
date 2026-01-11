import 'package:flutter/material.dart';
import 'mission_screen.dart';
import 'mission_model.dart';

class MissionCategoryScreen extends StatelessWidget {
  final List<Mission> cameraMissions;

  MissionCategoryScreen({required this.cameraMissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          '🎯 Missions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _categoryCard(
              context,
              emoji: '📸',
              title: 'Camera Missions',
              subtitle: 'Click photos & validate objects',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MissionScreen(missions: cameraMissions),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            _categoryCard(
              context,
              emoji: '🧠',
              title: 'Quiz Play',
              subtitle: 'Answer questions and earn coins',
              color: Colors.purple,
              onTap: () {
                _comingSoon(context);
              },
            ),
            SizedBox(height: 16),
            _categoryCard(
              context,
              emoji: '⚡',
              title: 'Generate Coins',
              subtitle: 'Daily rewards & bonuses',
              color: Colors.orange,
              onTap: () {
                _comingSoon(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: TextStyle(fontSize: 26)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('🚧 Coming Soon'),
        content: Text('This feature will be available soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
