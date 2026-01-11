import 'package:flutter/material.dart';

import '../../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final completedMissions = UserProvider.completedMissions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= PROFILE HEADER =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mission Explorer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ================= STATS SECTION =================
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statCard(
                    icon: Icons.account_balance_wallet,
                    title: 'Wallet',
                    value: '${UserProvider.walletPoints}',
                    color: Colors.green,
                  ),
                  _statCard(
                    icon: Icons.check_circle,
                    title: 'Missions',
                    value: '${completedMissions.length}',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            // ================= COMPLETED MISSIONS =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Completed Missions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            completedMissions.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No missions completed yet 🚀',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: completedMissions.length,
                    itemBuilder: (_, index) {
                      final mission = completedMissions[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(mission.title),
                          subtitle:
                              Text('Reward: ${mission.rewardPoints} points'),
                          trailing: Icon(
                            Icons.verified,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // ================= REUSABLE STAT CARD =================
  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 140,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
