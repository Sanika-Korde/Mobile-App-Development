import 'package:flutter/material.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exerciseController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _exerciseController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate()) {
      final exercise = _exerciseController.text;
      final sets = _setsController.text;
      final reps = _repsController.text;
      final weight = _weightController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workout Saved: $exercise ($sets x $reps @ $weight kg)')),
      );

      Navigator.pop(context); // Go back to workout screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _exerciseController,
                decoration: const InputDecoration(labelText: 'Exercise'),
                validator: (value) => value!.isEmpty ? 'Please enter exercise name' : null,
              ),
              TextFormField(
                controller: _setsController,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter number of sets' : null,
              ),
              TextFormField(
                controller: _repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter number of reps' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter weight' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveWorkout,
                child: const Text('Save Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
