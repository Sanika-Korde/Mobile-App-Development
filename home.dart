import 'package:flutter/material.dart';
import 'package:workout_tracker_app/screens/workout_screen.dart';
import 'package:workout_tracker_app/screens/diet_screen.dart';
import 'package:workout_tracker_app/screens/water_screen.dart';
import 'package:workout_tracker_app/screens/profile_screen.dart';
import 'package:workout_tracker_app/screens/health_issues_screen.dart';
import 'package:workout_tracker_app/screens/suggested_workouts_screen.dart';
import 'package:workout_tracker_app/screens/consistency_screen.dart';
import 'package:workout_tracker_app/screens/body_measurements_screen.dart';
import 'package:workout_tracker_app/screens/workout_completion_screen.dart';
import 'package:workout_tracker_app/screens/water_tracker_screen.dart';
import 'package:workout_tracker_app/screens/diet_planner_screen.dart';
import 'package:workout_tracker_app/screens/progress_tracking_screen.dart';
import 'package:workout_tracker_app/screens/todays_workout_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MainHomeScreen(), // Dashboard screen
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

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Track your fitness journey with ease.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // ✅ Today’s Workout
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodaysWorkoutScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.fitness_center, size: 28, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's Workout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Tap to view 6-day plan"),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(context, 'Water', Icons.water_drop, Colors.teal[100]!),
                _buildCard(context, 'Diet', Icons.restaurant, Colors.orange[100]!),
                _buildCard(context, 'Progress', Icons.show_chart, Colors.lightBlue[100]!),
              ],
            ),

            const SizedBox(height: 24),

            // ✅ Feature Grid
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildFeatureBox(context, 'Health Issues', Icons.healing, Colors.red[100]!, boxWidth, const HealthIssuesScreen()),
                _buildFeatureBox(context, 'Suggested Workouts', Icons.fitness_center, Colors.green[100]!, boxWidth, const SuggestedWorkoutsScreen()),
                _buildFeatureBox(context, 'Consistency', Icons.calendar_month, Colors.amber[100]!, boxWidth, const ConsistencyScreen()),
                _buildFeatureBox(context, 'Body Measurements', Icons.straighten, Colors.purple[100]!, boxWidth, const BodyMeasurementsScreen()),
                _buildFeatureBox(context, 'Workout Completion', Icons.check_circle, Colors.blue[100]!, boxWidth, const WorkoutCompletionScreen()),
              ],
            ),

            const SizedBox(height: 24),

            // ✅ Fitness Tips Image Banner
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    'https://tse4.mm.bing.net/th?id=OIP.rfYYfjzuiz84gYdjzIzMswHaEg&pid=Api&P=0&h=180',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(height: 180, width: double.infinity),
                  const Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      '💡 Stay Hydrated During Workout!',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String label, IconData icon, Color color) {
    Widget? destination;

    switch (label) {
      case 'Water':
        destination = const WaterTrackerScreen();
        break;
      case 'Diet':
        destination = const DietPlannerScreen();
        break;
      case 'Progress':
        destination = const ProgressTrackingScreen();
        break;
    }

    return InkWell(
      onTap: destination != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination!), // ✅ Fixed: added ! to cast Widget? to Widget
              )
          : null,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, size: 36, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildFeatureBox(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    double width,
    Widget screen,
  ) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Container(
        width: width,
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black87),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
