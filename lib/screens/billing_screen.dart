import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final consult = TextEditingController(text: '500');
  final meds = TextEditingController(text: '0');
  final lab = TextEditingController(text: '0');

  double get total {
    final c = double.tryParse(consult.text) ?? 0;
    final m = double.tryParse(meds.text) ?? 0;
    final l = double.tryParse(lab.text) ?? 0;
    return c + m + l;
  }

  @override
  void dispose() {
    consult.dispose();
    meds.dispose();
    lab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing & Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: consult,
              decoration: const InputDecoration(labelText: 'Consultation Fee'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: meds,
              decoration: const InputDecoration(labelText: 'Medicine Charges'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: lab,
              decoration: const InputDecoration(labelText: 'Lab Charges'),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rs. ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invoice Generated • Total = Rs. ${total.toStringAsFixed(0)}',
                      ),
                    ),
                  );
                },
                child: const Text('Generate Invoice'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
