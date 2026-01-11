import 'package:flutter/material.dart';
import 'mission_model.dart';
import 'mission_camera_screen.dart';

class MissionScreen extends StatelessWidget {
  final List<Mission> missions;

  MissionScreen({required this.missions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ---------------- APP BAR ----------------
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

      // ---------------- BODY ----------------
      body: missions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🎉', style: TextStyle(fontSize: 50)),
                  SizedBox(height: 12),
                  Text(
                    'No missions available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12),
              itemCount: missions.length,
              itemBuilder: (_, index) {
                final mission = missions[index];
                final completed = mission.isCompleted;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                    // Icon
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: completed
                            ? Colors.green.shade100
                            : Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        completed ? '✅' : '📸',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    // Title & Description
                    title: Text(
                      mission.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        mission.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    // Action Button
                    trailing: completed
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              final completed = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MissionCameraScreen(mission: mission),
                                ),
                              );

                              if (completed == true) {
                                // Force refresh
                                (context as Element).markNeedsBuild();
                              }
                            },
                            child: Text(
                              'Start',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
