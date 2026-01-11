import 'package:flutter/material.dart';
import '../features/wallet/coins_history_screen.dart';
import '../features/wallet/wallet_screen.dart';
import '../features/missions/mission_screen.dart';
import '../features/missions/mission_model.dart';

class BottomActionBar extends StatelessWidget {
  final List<Mission> missions;

  BottomActionBar({required this.missions});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 💰 COINS HISTORY
            _bottomButton(
              emoji: '💰',
              label: 'History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CoinsHistoryScreen(missions: missions),
                  ),
                );
              },
            ),

            // 🎯 MISSIONS
            _bottomButton(
              emoji: '🎯',
              label: 'Missions',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MissionScreen(missions: missions),
                  ),
                  (route) => false,
                );
              },
            ),

            // 🪙 COINS / WALLET
            _bottomButton(
              emoji: '🪙',
              label: 'Coins',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WalletScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton({
    required String emoji,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 22)),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
