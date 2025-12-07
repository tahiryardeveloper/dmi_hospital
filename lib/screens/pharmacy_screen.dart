import 'package:flutter/material.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  final List<Map<String, dynamic>> meds = [
    {'name': 'Paracetamol', 'stock': 120},
    {'name': 'Amoxicillin', 'stock': 35},
    {'name': 'Aspirin', 'stock': 5},
  ];

  List<Map<String, dynamic>> get filteredList {
    final q = searchCtrl.text.toLowerCase();
    if (q.isEmpty) return meds;
    return meds.where((m) => m['name'].toLowerCase().contains(q)).toList();
  }

  void issueMedicine(int index) {
    if (filteredList[index]['stock'] > 0) {
      setState(() {
        filteredList[index]['stock']--;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Medicine Issued')));
    }
  }

  void addMedicineDialog() {
    final nameCtrl = TextEditingController();
    final stockCtrl = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add Medicine'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Medicine Name'),
                ),
                TextField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(labelText: 'Initial Stock'),
                  keyboardType: TextInputType.number,
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
                  final name = nameCtrl.text.trim();
                  final stock = int.tryParse(stockCtrl.text) ?? 0;

                  if (name.isNotEmpty) {
                    setState(() {
                      meds.add({'name': name, 'stock': stock});
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  Color stockColor(int stock) {
    if (stock <= 5) return Colors.red;
    if (stock <= 20) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Management'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: addMedicineDialog),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // ------------------ SEARCH ------------------
            TextField(
              controller: searchCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search medicine...',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 12),

            // ------------------ MED LIST ------------------
            Expanded(
              child: ListView.separated(
                itemCount: filteredList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  final m = filteredList[i];
                  final stock = m['stock'] as int;

                  return ListTile(
                    leading: Icon(
                      Icons.local_pharmacy,
                      color: stockColor(stock),
                    ),
                    title: Text(m['name']),
                    subtitle: Text(
                      'Stock: $stock',
                      style: TextStyle(
                        color: stockColor(stock),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: stock == 0 ? null : () => issueMedicine(i),
                      child: const Text('Issue'),
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
