import 'package:flutter/material.dart';

class TodaysWorkoutScreen extends StatelessWidget {
  const TodaysWorkoutScreen({super.key});

  final List<String> days = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  final Map<String, List<String>> workouts = const {
    "Monday": ["Push-ups", "Bench Press", "Shoulder Press"],
    "Tuesday": ["Squats", "Lunges", "Leg Press"],
    "Wednesday": ["Pull-ups", "Deadlift", "Bicep Curls"],
    "Thursday": ["Plank", "Mountain Climbers", "Crunches"],
    "Friday": ["Burpees", "Jump Rope", "High Knees"],
    "Saturday": ["Yoga", "Stretching", "Light Jog"],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: days.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Today's Workout"),
          backgroundColor: const Color.fromARGB(255, 244, 226, 63),
          bottom: TabBar(
            isScrollable: true,
            tabs: days.map((day) => Tab(text: day)).toList(),
          ),
        ),
        body: TabBarView(
          children: days.map((day) {
            final exercises = workouts[day]!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(exercises[index]),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
