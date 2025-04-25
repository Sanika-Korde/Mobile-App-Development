import 'package:flutter/material.dart';

class HealthIssuesScreen extends StatefulWidget {
  const HealthIssuesScreen({super.key});

  @override
  State<HealthIssuesScreen> createState() => _HealthIssuesScreenState();
}

class _HealthIssuesScreenState extends State<HealthIssuesScreen> {
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _recommendationController = TextEditingController();

  List<Map<String, String>> _issues = [
    {
      'issue': 'Knee Pain',
      'recommendation': 'Avoid squats and leg press',
    },
    {
      'issue': 'Shoulder Strain',
      'recommendation': 'Avoid overhead lifts',
    },
  ];

  void _addIssue(String issue, String recommendation) {
    setState(() {
      _issues.add({'issue': issue, 'recommendation': recommendation});
    });
  }

  void _showAddIssueDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Health Issue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _issueController,
                decoration: const InputDecoration(labelText: 'Issue'),
              ),
              TextField(
                controller: _recommendationController,
                decoration: const InputDecoration(labelText: 'Recommendation'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _issueController.clear();
                _recommendationController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_issueController.text.isNotEmpty && _recommendationController.text.isNotEmpty) {
                  _addIssue(_issueController.text, _recommendationController.text);
                  Navigator.of(context).pop();
                  _issueController.clear();
                  _recommendationController.clear();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 67, 54),
        title: const Text('🩺 Health Issues'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Current Health Concerns',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ..._issues.map((issueData) => Card(
                child: ListTile(
                  leading: const Icon(Icons.healing, color: Colors.red),
                  title: Text(issueData['issue']!),
                  subtitle: Text(issueData['recommendation']!),
                  trailing: const Icon(Icons.edit),
                ),
              )),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 50),foregroundColor: Colors.white,
            ),
            onPressed: _showAddIssueDialog,
            icon: const Icon(Icons.add),
            label: const Text("Add New Issue"),
          ),
        ],
      ),
    );
  }
}
