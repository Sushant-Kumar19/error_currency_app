import 'package:flutter/material.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/shop/shop_screen.dart';
import 'features/wallet/wallet_screen.dart';
import 'features/missions/mission_screen.dart';
import 'features/wallet/coins_history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureForce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginScreen(),
        '/dashboard': (_) => DashboardScreen(),
        '/shop': (_) => ShopScreen(),
        '/wallet': (_) => WalletScreen(),
        '/missions': (_) =>
            MissionScreen(missions: []), // Pass actual list when navigating
        '/history': (_) => CoinsHistoryScreen(
            missions: []), // Pass actual list when navigating
      },
    );
  }
}
