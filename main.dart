import 'package:flutter/material.dart';
import 'package:workout_tracker_app/screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/workout_screen.dart';
import 'screens/diet_screen.dart';
import 'screens/water_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/health_issues_screen.dart';
import 'screens/suggested_workouts_screen.dart';
import 'screens/consistency_screen.dart';
import 'screens/body_measurements_screen.dart';
import 'screens/workout_completion_screen.dart'; // 👈 Add this line

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 👈 Add this line here
      home: LoginScreen(),
    );
  }
}
