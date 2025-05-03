import 'package:flutter/material.dart';

class BodyMeasurementsScreen extends StatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  State<BodyMeasurementsScreen> createState() => _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState extends State<BodyMeasurementsScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _chestController.dispose();
    super.dispose();
  }

  void _saveMeasurements() {
    // You can integrate this with a database later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Measurements saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 202, 229),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('📏 Body Measurements'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildInputField('Height (cm)', _heightController),
            _buildInputField('Weight (kg)', _weightController),
            _buildInputField('Waist (cm)', _waistController),
            _buildInputField('Chest (cm)', _chestController),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 221, 79, 247),
                minimumSize: const Size(double.infinity, 50),foregroundColor: Colors.white
              ),
              onPressed: _saveMeasurements,
              icon: const Icon(Icons.save),
              label: const Text("Save Measurements"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
