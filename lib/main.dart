import 'package:flutter/material.dart';
import 'theme/app_color.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard.dart';
import 'screens/patient_registration.dart';
import 'screens/doctor_list.dart';
import 'screens/appointment_screen.dart';
import 'screens/patient_record.dart';
import 'screens/billing_screen.dart';
import 'screens/pharmacy_screen.dart';
import 'screens/lab_screen.dart';
import 'screens/setting_screen.dart';

void main() {
  runApp(const HMSApp());
}

class HMSApp extends StatelessWidget {
  const HMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS Frontend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.bg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/patient_register': (_) => const PatientRegisterScreen(),
        '/doctors': (_) => const DoctorListScreen(),
        '/appointments': (_) => const AppointmentScreen(),
        '/patient_records': (_) => const PatientRecordsScreen(),
        '/billing': (_) => const BillingScreen(),
        '/pharmacy': (_) => const PharmacyScreen(),
        '/lab_reports': (_) => const LabReportsScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
