import 'package:flutter/material.dart';
import 'dart:math';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final List<Map<String, String>> doctors = List.generate(
    8,
    (i) => {
      'name': 'Dr. Doctor ${i + 1}',
      'specialty': specialties[Random().nextInt(specialties.length)],
      'timing': timings[Random().nextInt(timings.length)],
    },
  );

  List<Map<String, String>> filteredDoctors = [];

  static const List<String> specialties = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Pediatrics',
    'General',
    'Orthopedics',
  ];

  static const List<String> timings = [
    '9am - 2pm',
    '10am - 4pm',
    '11am - 3pm',
    '1pm - 6pm',
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
  }

  void showDoctorDialog({Map<String, String>? doctor, int? index}) {
    final TextEditingController nameController = TextEditingController(
      text: doctor?['name'] ?? '',
    );
    String? selectedSpecialty = doctor?['specialty'] ?? specialties[0];
    String? selectedTiming = doctor?['timing'] ?? timings[0];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(doctor == null ? 'Add Doctor' : 'Edit Doctor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Doctor Name',
                    hintText: 'Enter doctor name',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedSpecialty,
                  decoration: const InputDecoration(labelText: 'Specialty'),
                  items:
                      specialties
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                  onChanged: (val) => selectedSpecialty = val,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedTiming,
                  decoration: const InputDecoration(labelText: 'Timing'),
                  items:
                      timings
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                  onChanged: (val) => selectedTiming = val,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    setState(() {
                      final newDoctor = {
                        'name': nameController.text,
                        'specialty': selectedSpecialty!,
                        'timing': selectedTiming!,
                      };

                      if (doctor == null) {
                        // Add new
                        doctors.add(newDoctor);
                        filteredDoctors.add(newDoctor);
                      } else {
                        // Edit existing
                        final originalIndex = doctors.indexOf(doctor);
                        doctors[originalIndex] = newDoctor;
                        filteredDoctors[index!] = newDoctor;
                      }
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text(doctor == null ? 'Add' : 'Update'),
              ),
            ],
          ),
    );
  }

  void removeDoctor(int index) {
    setState(() {
      final removedDoctor = filteredDoctors[index];
      doctors.remove(removedDoctor);
      filteredDoctors.removeAt(index);
    });
  }

  void filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = List.from(doctors);
      } else {
        filteredDoctors =
            doctors
                .where(
                  (doctor) => doctor['name']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Search bar
            TextField(
              onChanged: filterDoctors,
              decoration: const InputDecoration(
                labelText: 'Search Doctor',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, i) {
                  final doctor = filteredDoctors[i];
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(doctor['name']!),
                      subtitle: Text(
                        '${doctor['specialty']} • ${doctor['timing']}',
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'remove') removeDoctor(i);
                          if (value == 'edit')
                            showDoctorDialog(doctor: doctor, index: i);
                        },
                        itemBuilder:
                            (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDoctorDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
