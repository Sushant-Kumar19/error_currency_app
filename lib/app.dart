import 'package:flutter/material.dart';
import 'package:real_world_app/features/auth/login_screen.dart';
// import 'features/missions/mission_screen.dart';/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Camera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
