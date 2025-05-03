import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? bmi;
  String status = "";
  String tips = "";

  void calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      double heightMeters = height / 100;
      double result = weight / (heightMeters * heightMeters);
      setState(() {
        bmi = result;
        if (bmi! < 18.5) {
          status = "Underweight";
          tips = "Try to eat more calorie-rich foods and do strength training.";
        } else if (bmi! >= 18.5 && bmi! < 25) {
          status = "Normal";
          tips = "You're doing great! Keep maintaining a balanced diet and regular workouts.";
        } else {
          status = "Overweight";
          tips = "Reduce sugar intake, increase cardio, and eat more vegetables.";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: calculateBMI,
                child: const Text("Calculate BMI"),
              ),
            ),
            if (bmi != null) ...[
              const SizedBox(height: 20),
              Text("Your BMI is: ${bmi!.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Status: $status", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text("Tips:", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(tips),
            ]
          ],
        ),
      ),
    );
  }
}