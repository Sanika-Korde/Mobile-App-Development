import 'package:flutter/material.dart';
import 'health_issues_screen.dart';
import 'suggested_workouts_screen.dart';
import 'consistency_screen.dart';
import 'body_measurements_screen.dart';
import 'workout_completion_screen.dart';
import 'water_tracker_screen.dart';
import 'diet_planner_screen.dart';
import 'progress_tracking_screen.dart';
import 'todays_workout_screen.dart';
import 'login_screen.dart'; // 👈 NEW import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boxWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Smaller login icon
            const SizedBox(width: 8),
            const Text(
              "Workout Tracker            ", // App name
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.login, size: 22), // Smaller login icon
                  SizedBox(width: 4),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 16), // Smaller text size
                  ),
                ],
              ),
            ),
          ],
        ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(context, 'Water', Icons.water_drop, Colors.teal[100]!),
                _buildCard(context, 'Diet', Icons.restaurant, Colors.orange[100]!),
                _buildCard(context, 'Progress', Icons.show_chart, Colors.lightBlue[100]!),
              ],
            ),

            const SizedBox(height: 24),

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
                      '💡Stay Hydrated During Workout!',
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
          ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination!))
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


