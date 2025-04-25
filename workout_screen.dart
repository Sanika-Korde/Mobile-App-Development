import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<Map<String, String>> _workouts = [];

  void _addWorkout() {
    String name = '';
    String sets = '';
    String reps = '';
    String weight = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Workout"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Workout Name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Sets'),
              onChanged: (value) => sets = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Reps'),
              onChanged: (value) => reps = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              onChanged: (value) => weight = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name.isNotEmpty) {
                setState(() {
                  _workouts.add({
                    'name': name,
                    'sets': sets,
                    'reps': reps,
                    'weight': weight,
                  });
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Workout Tracker"),
      ),
      body: _workouts.isEmpty
          ? const Center(child: Text("No workouts added yet."))
          : ListView.builder(
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.teal.shade100,
                  child: ListTile(
                    title: Text(workout['name'] ?? ''),
                    subtitle: Text(
                        "Sets: ${workout['sets']}, Reps: ${workout['reps']}, Weight: ${workout['weight']} kg"),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _addWorkout,
        child: const Icon(Icons.add),
      ),
    );
  }
}
