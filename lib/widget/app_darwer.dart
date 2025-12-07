import 'package:flutter/material.dart';
import 'package:hms/theme/app_color.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onNavigate;
  const AppDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hospital',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Management System',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => onNavigate('/dashboard'),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Register Patient'),
              onTap: () => onNavigate('/patient_register'),
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Doctors'),
              onTap: () => onNavigate('/doctors'),
            ),
            ListTile(
              leading: const Icon(Icons.event_available),
              title: const Text('Appointments'),
              onTap: () => onNavigate('/appointments'),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Billing'),
              onTap: () => onNavigate('/billing'),
            ),
            ListTile(
              leading: const Icon(Icons.local_pharmacy),
              title: const Text('Pharmacy'),
              onTap: () => onNavigate('/pharmacy'),
            ),
            ListTile(
              leading: const Icon(Icons.biotech),
              title: const Text('Lab Reports'),
              onTap: () => onNavigate('/lab_reports'),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => onNavigate('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}
