import 'package:flutter/material.dart';
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
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WorkoutScreen(),
    const DietScreen(),
    const WaterScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Diet'),
          BottomNavigationBarItem(icon: Icon(Icons.opacity), label: 'Water'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
