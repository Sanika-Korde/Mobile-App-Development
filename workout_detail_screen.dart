import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final String title;
  final String type;
  final String duration;

  const WorkoutDetailScreen({
    super.key,
    required this.title,
    required this.type,
    required this.duration,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;

  int _parseDurationToSeconds(String duration) {
    // e.g. "30 mins" -> 1800 seconds
    final mins = int.tryParse(duration.split(' ').first) ?? 0;
    return mins * 60;
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = _parseDurationToSeconds(widget.duration);
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Workout complete!")),
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Workout Type: ${widget.type}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Duration: ${widget.duration}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Center(
              child: Text(
                _formatTime(_remainingSeconds),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: _isRunning
                  ? ElevatedButton.icon(
                      icon: const Icon(Icons.stop),
                      label: const Text("Stop"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: _stopTimer,
                    )
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Start Timer"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: _startTimer,
                    ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Instructions:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "- Warm up for 5 minutes\n"
              "- Follow exercise sequence\n"
              "- Stay hydrated and rest as needed\n"
              "- Cool down for 5 minutes",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
