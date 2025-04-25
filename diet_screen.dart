import 'package:flutter/material.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({super.key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController _mealController = TextEditingController();
  final List<Map<String, String>> _meals = [];
  String _selectedType = 'Breakfast';

  void _addMeal() {
    final meal = _mealController.text.trim();
    if (meal.isNotEmpty) {
      setState(() {
        _meals.add({'type': _selectedType, 'meal': meal});
        _mealController.clear();
      });
    }
  }

  final List<String> _mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet & Nutrition'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _mealTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Meal Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _mealController,
              decoration: InputDecoration(
                labelText: 'Enter Meal',
                hintText: 'e.g. Eggs, Oats, Chicken Salad...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addMeal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Save Meal',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Saved Meals:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.check_circle_outline,
                      color: Colors.orange),
                  title: Text(_meals[index]['meal']!),
                  subtitle: Text(_meals[index]['type']!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
