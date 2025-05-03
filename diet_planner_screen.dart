import 'package:flutter/material.dart';

class DietPlannerScreen extends StatefulWidget {
  const DietPlannerScreen({super.key});

  @override
  State<DietPlannerScreen> createState() => _DietPlannerScreenState();
}

class _DietPlannerScreenState extends State<DietPlannerScreen> {
  final List<Map<String, dynamic>> _meals = [];

  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  int get _totalCalories =>
      _meals.fold(0, (sum, item) => sum + (item['calories'] as int));

  void _addMeal() {
    if (_mealController.text.isNotEmpty &&
        int.tryParse(_caloriesController.text) != null) {
      setState(() {
        _meals.add({
          'meal': _mealController.text,
          'calories': int.parse(_caloriesController.text),
        });
        _mealController.clear();
        _caloriesController.clear();
      });
    }
  }

  void _removeMeal(int index) {
    setState(() {
      _meals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Planner"),
        backgroundColor: const Color.fromARGB(255, 122, 76, 201),foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _mealController,
              decoration: const InputDecoration(labelText: 'Meal'),
            ),
            TextField(
              controller: _caloriesController,
              decoration: const InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addMeal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,foregroundColor: Colors.white,
              ),
              child: const Text("Add Meal"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return Card(
                    child: ListTile(
                      title: Text(meal['meal']),
                      subtitle: Text('${meal['calories']} cal'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeMeal(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              'Total Calories: $_totalCalories',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
