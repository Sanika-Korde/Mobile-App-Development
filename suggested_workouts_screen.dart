import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SuggestedWorkoutsScreen extends StatelessWidget {
  const SuggestedWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> workouts = [
      {
        'title': 'Full Body Blast',
        'type': 'Strength',
        'duration': 45,
        'exercises': [
          'Squats (3x15)',
          'Push-ups (3x10)',
          'Lunges (3x12)',
        ]
      },
      {
        'title': 'Fat Burn Cardio',
        'type': 'Cardio',
        'duration': 30,
        'exercises': [
          'Jumping Jacks (3x30s)',
          'Burpees (3x15)',
          'High Knees (3x30s)',
        ]
      },
      {
        'title': 'Core Crusher',
        'type': 'Abs',
        'duration': 20,
        'exercises': [
          'Plank (3x30s)',
          'Crunches (3x20)',
          'Leg Raises (3x15)',
          'Plank',
        ]
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 255, 191),
      appBar: AppBar(
        title: const Text('💡 Suggested Workouts'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.flash_on, color: Colors.green),
              title: Text(workout['title']),
              subtitle: Text('${workout['type']} • ${workout['duration']} mins'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutStartScreen(
                        title: workout['title'],
                        duration: workout['duration'],
                        exercises: workout['exercises'],
                      ),
                    ),
                  );
                },
                child: const Text("Start"),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WorkoutStartScreen extends StatefulWidget {
  final String title;
  final int duration;
  final List<String> exercises;

  const WorkoutStartScreen({super.key, required this.title, required this.duration, required this.exercises});

  @override
  State<WorkoutStartScreen> createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends State<WorkoutStartScreen> {
  bool isTimer = true;
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _seconds = isTimer ? widget.duration * 60 : 0;
  }

  void toggleMode() {
    setState(() {
      isTimer = !isTimer;
      _timer?.cancel();
      _isRunning = false;
      _seconds = isTimer ? widget.duration * 60 : 0;
    });
  }

  void startStopwatch() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (isTimer) {
            if (_seconds > 0) {
              _seconds--;
            } else {
              timer.cancel();
              saveCompletion();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Workout Complete!"),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                ),
              );
            }
          } else {
            _seconds++;
          }
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = isTimer ? widget.duration * 60 : 0;
    });
  }

  Future<void> saveCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'completedWorkouts';
    final now = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    List<String> history = prefs.getStringList(key) ?? [];
    history.add('${widget.title} at $now');
    await prefs.setStringList(key, history);
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(isTimer ? Icons.timer : Icons.av_timer),
            onPressed: toggleMode,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isTimer ? "Timer Mode" : "Stopwatch Mode",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  formattedTime,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startStopwatch,
                    child: Text(_isRunning ? "Pause" : "Start"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: resetTimer,
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("Exercises:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...widget.exercises.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("• $e", style: const TextStyle(fontSize: 16)),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
