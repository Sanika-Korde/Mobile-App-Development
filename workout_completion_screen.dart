import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutCompletionScreen extends StatefulWidget {
  const WorkoutCompletionScreen({super.key});

  @override
  State<WorkoutCompletionScreen> createState() =>
      _WorkoutCompletionScreenState();
}

class _WorkoutCompletionScreenState extends State<WorkoutCompletionScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Set<DateTime> _completedDays = {};

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 209, 255),
      appBar: AppBar(
        title: const Text("📅 Workout Completion"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate:
                (day) => _isSameDay(_selectedDay ?? DateTime.now(), day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final isCompleted = _completedDays.any(
                  (d) => _isSameDay(d, day),
                );
                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isCompleted ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              if (_selectedDay != null) {
                setState(() {
                  _completedDays.add(_selectedDay!);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(200, 48),
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.check),
            label: const Text("Mark as Completed"),
          ),
        ],
      ),
    );
  }
}
