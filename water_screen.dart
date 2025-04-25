import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  int _waterCups = 0;

  void _incrementWater() {
    setState(() {
      _waterCups++;
    });
  }

  void _resetWater() {
    setState(() {
      _waterCups = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Daily Water Tracker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              '$_waterCups Cups',
              style: const TextStyle(fontSize: 40, color: Colors.teal),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _incrementWater,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.water_drop),
              label: const Text(
                'Add Water',
                style: TextStyle(fontSize: 18,color: Color.fromARGB(215, 255, 255, 255)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _resetWater,
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
