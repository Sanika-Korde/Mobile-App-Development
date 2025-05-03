import 'package:flutter/material.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  int _waterIntake = 0;
  final int _goal = 3000;

  void _addWater(int amount) {
    setState(() {
      _waterIntake += amount;
      if (_waterIntake > _goal) _waterIntake = _goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _goal - _waterIntake;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker"),
        backgroundColor: Colors.deepPurple,foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Today's Intake",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '$_waterIntake ml / $_goal ml',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _waterIntake / _goal,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 15,
            ),
            const SizedBox(height: 40),
            const Text('Add Water:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () => _addWater(200),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('+200 ml'),
                ),
                ElevatedButton(
                  onPressed: () => _addWater(500),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('+500 ml'),
                ),
              ],
            ),
            const Spacer(),
            if (remaining > 0)
              Text('You need $remaining ml more today!',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
            if (remaining <= 0)
              const Text('🎉 Goal Reached!',
                  style: TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
