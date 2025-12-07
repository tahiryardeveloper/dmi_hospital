import 'package:flutter/material.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  final _form = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController();
  final phone = TextEditingController();
  final disease = TextEditingController();
  String gender = 'Male';

  void save() {
    if (_form.currentState!.validate()) {
      // Demo: just show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Patient Registered (demo)')));
      // Clear
      name.clear();
      age.clear();
      phone.clear();
      disease.clear();
      setState(() { gender = 'Male'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Patient')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Full Name'), validator: (v) => v!.isEmpty ? 'Enter name' : null),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: TextFormField(controller: age, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: DropdownButtonFormField<String>(
                  value: gender,
                  items: ['Male','Female','Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (v) => setState(() { gender = v!; }),
                  decoration: const InputDecoration(labelText: 'Gender'),
                )),
              ]),
              const SizedBox(height: 8),
              TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
              const SizedBox(height: 8),
              TextFormField(controller: disease, decoration: const InputDecoration(labelText: 'Disease / Complaint')),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Save Patient'))),
            ],
          ),
        ),
      ),
    );
  }
}
