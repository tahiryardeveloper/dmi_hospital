import 'package:flutter/material.dart';
import 'package:hms/widget/app_darwer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final int totalPatients = 1245;
  final int totalDoctors = 45;
  final int todayAppointments = 38;

  final List<Map<String, String>> todayList = const [
    {'patient': 'Ali', 'doctor': 'Dr. Ahmed', 'time': '10:00 AM'},
    {'patient': 'Sara', 'doctor': 'Dr. Bilal', 'time': '10:30 AM'},
    {'patient': 'Usman', 'doctor': 'Dr. Sana', 'time': '11:00 AM'},
    {'patient': 'Ayesha', 'doctor': 'Dr. Ahmed', 'time': '11:30 AM'},
    {'patient': 'Zain', 'doctor': 'Dr. Bilal', 'time': '12:00 PM'},
  ];

  void navigate(BuildContext context, String route) {
    if (route == '/dashboard') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      drawer: AppDrawer(
        onNavigate: (route) {
          Navigator.pop(context);
          navigate(context, route);
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          final crossAxis = isWide ? 3 : (constraints.maxWidth > 600 ? 2 : 1);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // ---------------- Dashboard Cards ----------------
                GridView.count(
                  crossAxisCount: crossAxis,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  children: [
                    _dashboardCard(
                      title: 'Total Patients',
                      value: totalPatients.toString(),
                      icon: Icons.people,
                      color: Colors.blue,
                      onTap: () => navigate(context, '/patient_records'),
                    ),
                    _dashboardCard(
                      title: 'Total Doctors',
                      value: totalDoctors.toString(),
                      icon: Icons.medical_services,
                      color: Colors.green,
                      onTap: () => navigate(context, '/doctors'),
                    ),
                    _dashboardCard(
                      title: 'Today Appointments',
                      value: todayAppointments.toString(),
                      icon: Icons.event_available,
                      color: Colors.orange,
                      onTap: () => navigate(context, '/appointments'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // ---------------- Quick Actions ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _quickActionCard(
                      icon: Icons.person_add,
                      label: 'Register Patient',
                      color: Colors.teal,
                      onTap: () => navigate(context, '/patient_register'),
                    ),
                    _quickActionCard(
                      icon: Icons.receipt_long,
                      label: 'Billing',
                      color: Colors.deepOrange,
                      onTap: () => navigate(context, '/billing'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // ---------------- Today Appointments ----------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today Appointments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      itemCount: todayList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        final appointment = todayList[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                appointment['patient']![0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(appointment['patient']!),
                            subtitle: Text(
                              '${appointment['doctor']} • ${appointment['time']}',
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed:
                                  () => navigate(context, '/patient_records'),
                              child: const Text('View'),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _dashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white24,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
