import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime = DateTime(2023, 12, 24, 5, 30);
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Date and Time",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final date = await pickDate();
                      if (date == null) return;
                      setState(() {
                        dateTime = date;
                      });
                    },
                    child: Text(
                        '${dateTime.year}/${dateTime.month}/${dateTime.day}')),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          final time = await pickTime();
                          if (time == null) return;

                          final newDateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              time.hour,
                              time.minute);
                          setState(() {
                            dateTime = newDateTime;
                          });
                        },
                        child: Text('$hours:$minutes')))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() {
    return showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
  }

  Future<TimeOfDay?> pickTime() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
  }
}
