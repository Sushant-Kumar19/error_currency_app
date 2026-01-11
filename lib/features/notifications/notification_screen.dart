import 'package:flutter/material.dart';
import '../missions/mission_model.dart';

class NotificationScreen extends StatelessWidget {
  final List<Mission> missions;

  NotificationScreen({required this.missions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Updates'),
        centerTitle: true,
      ),
      body: missions.isEmpty
          ? Center(child: Text('No missions available'))
          : ListView.builder(
              itemCount: missions.length,
              itemBuilder: (_, index) {
                final mission = missions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      mission.isCompleted
                          ? Icons.check_circle
                          : Icons.hourglass_bottom,
                      color: mission.isCompleted ? Colors.green : Colors.orange,
                    ),
                    title: Text(mission.title),
                    subtitle: Text(
                      'Reward: ${mission.rewardPoints} points',
                    ),
                    trailing: Text(
                      mission.isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            mission.isCompleted ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
