import 'package:flutter/material.dart';

class PatientRecordsScreen extends StatelessWidget {
  const PatientRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = List.generate(6, (i) => {
      'name': 'Patient ${i+1}',
      'date': '2025-0${i+1}-10',
      'doctor': 'Dr. ${['Ahmed','Sara','Khan'][i%3]}'
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Records')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
          itemCount: records.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, i) {
            final r = records[i];
            return ListTile(
              leading: CircleAvatar(child: Text('${i+1}')),
              title: Text(r['name']!),
              subtitle: Text('${r['doctor']} • ${r['date']}'),
              trailing: TextButton(
                onPressed: () { /* open patient detail - for demo reuse appointment */ Navigator.pushNamed(context, '/appointments'); },
                child: const Text('Open'),
              ),
            );
          },
        ),
      ),
    );
  }
}
