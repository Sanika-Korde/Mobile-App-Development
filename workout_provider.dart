import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  final List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  void addWorkout(String title) {
    _workouts.add(Workout(title: title));
    notifyListeners();
  }

  void toggleWorkout(int index) {
    _workouts[index].isDone = !_workouts[index].isDone;
    notifyListeners();
  }

  void deleteWorkout(int index) {
    _workouts.removeAt(index);
    notifyListeners();
  }
}
