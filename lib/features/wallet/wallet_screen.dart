import 'package:flutter/material.dart';
import '../../providers/user_provider.dart';
import '../wallet/coins_history_screen.dart';
// import '../missions/mission_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../missions/mission_data.dart';
import '../missions/mission_category_screen.dart';
// import '../missions/mission_data.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        title: Text('🪙 Wallet'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------------- WALLET CARD ----------------
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Total Coins',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '🪙 ${UserProvider.walletPoints}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // ---------------- ACTION BUTTONS ----------------
            _actionTile(
              context,
              emoji: '💰',
              title: 'Coins History',
              subtitle: 'View your earned rewards',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CoinsHistoryScreen(missions: allMissions),
                  ),
                );
              },
            ),

            _actionTile(
              context,
              emoji: '🎯',
              title: 'Go to Missions',
              subtitle: 'Choose camera, quiz or coin missions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MissionCategoryScreen(
                      cameraMissions:
                          allMissions.where((m) => !m.isCompleted).toList(),
                    ),
                  ),
                );
              },
            ),

            _actionTile(
              context,
              emoji: '🏠',
              title: 'Back to Dashboard',
              subtitle: 'Return to home screen',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => DashboardScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- REUSABLE TILE ----------------
  Widget _actionTile(
    BuildContext context, {
    required String emoji,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Text(emoji, style: TextStyle(fontSize: 22)),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
