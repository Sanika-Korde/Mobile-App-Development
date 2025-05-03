import 'package:flutter/material.dart';

class ConsistencyScreen extends StatefulWidget {
  const ConsistencyScreen({super.key});

  @override
  State<ConsistencyScreen> createState() => _ConsistencyScreenState();
}

class _ConsistencyScreenState extends State<ConsistencyScreen> {
  final Map<String, bool> _weeklyConsistency = {
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
    'Sun': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 198),
      appBar: AppBar(
        title: const Text("📅 Consistency Tracker"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mark the days you worked out:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _weeklyConsistency.keys.map((day) {
                return FilterChip(
                  label: Text(day),
                  selected: _weeklyConsistency[day]!,
                  selectedColor: Colors.amber,
                  onSelected: (val) {
                    setState(() {
                      _weeklyConsistency[day] = val;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved successfully!')),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Progress'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
