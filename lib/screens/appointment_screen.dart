import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? selectedPatient;
  String? selectedDoctor;
  DateTime selectedDate = DateTime.now();

  void book() {
    if (selectedPatient == null || selectedDoctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select patient and doctor')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment booked (demo)')));
  }

  @override
  Widget build(BuildContext context) {
    final patients = ['Patient A','Patient B','Patient C'];
    final doctors = ['Dr. Ahmed','Dr. Sara','Dr. Khan'];

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedPatient,
              hint: const Text('Select Patient'),
              items: patients.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => selectedPatient = v),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedDoctor,
              hint: const Text('Select Doctor'),
              items: doctors.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: (v) => setState(() => selectedDoctor = v),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
              trailing: ElevatedButton(
                onPressed: () async {
                  final dt = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (dt != null) setState(() => selectedDate = dt);
                },
                child: const Text('Pick Date'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: book, child: const Text('Book Appointment'))),
          ],
        ),
      ),
    );
  }
}
