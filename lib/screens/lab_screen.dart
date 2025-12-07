import 'package:flutter/material.dart';

class LabReportsScreen extends StatefulWidget {
  const LabReportsScreen({super.key});

  @override
  State<LabReportsScreen> createState() => _LabReportsScreenState();
}

class _LabReportsScreenState extends State<LabReportsScreen> {
  String search = '';

  final List<Map<String, dynamic>> reports = [
    {
      'name': 'Blood Test',
      'patient': 'Ali',
      'status': 'Completed',
      'date': '10 Mar',
    },
    {'name': 'X-Ray', 'patient': 'Sara', 'status': 'Pending', 'date': '11 Mar'},
    {
      'name': 'MRI Scan',
      'patient': 'Usman',
      'status': 'Completed',
      'date': '12 Mar',
    },
    {
      'name': 'Urine Test',
      'patient': 'Ayesha',
      'status': 'Pending',
      'date': '13 Mar',
    },
    {'name': 'ECG', 'patient': 'Zain', 'status': 'Completed', 'date': '14 Mar'},
  ];

  void showDetails(Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(report['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Patient: ${report['patient']}'),
                Text('Date: ${report['date']}'),
                Text('Status: ${report['status']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        reports
            .where(
              (r) =>
                  r['name'].toLowerCase().contains(search.toLowerCase()) ||
                  r['patient'].toLowerCase().contains(search.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Lab Reports')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search by report or patient',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => search = v),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  final r = filtered[i];
                  final isCompleted = r['status'] == 'Completed';

                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            isCompleted ? Colors.green : Colors.orange,
                        child: const Icon(Icons.science, color: Colors.white),
                      ),
                      title: Text(r['name']),
                      subtitle: Text('Patient: ${r['patient']} • ${r['date']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () => showDetails(r),
                          ),
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Report downloaded'),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() => reports.removeAt(i));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
