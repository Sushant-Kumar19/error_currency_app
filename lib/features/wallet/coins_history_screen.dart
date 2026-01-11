import 'package:flutter/material.dart';
import '../missions/mission_model.dart';

class CoinsHistoryScreen extends StatelessWidget {
  final List<Mission> missions;

  CoinsHistoryScreen({required this.missions});

  @override
  Widget build(BuildContext context) {
    // Filter only completed missions
    final completedMissions =
        missions.where((mission) => mission.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('💰 Coins History'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Text('🎯'),
        label: Text('Go to Missions'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: completedMissions.isEmpty
          ? Center(
              child: Text(
                'No coin history yet',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            )
          : ListView.builder(
              itemCount: completedMissions.length,
              itemBuilder: (_, index) {
                final mission = completedMissions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Text(
                      '✅',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    title: Text(mission.title),
                    subtitle: Text(
                      'Earned ${mission.rewardPoints} coins',
                    ),
                    trailing: Text(
                      '+${mission.rewardPoints}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
