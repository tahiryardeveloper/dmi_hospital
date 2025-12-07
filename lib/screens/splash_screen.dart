import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    startApp();
  }

  void startApp() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() => isLoading = false);

    await Future.delayed(const Duration(milliseconds: 700));

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: _scaleAnim.value,
                  child: const Icon(
                    Icons.local_hospital,
                    size: 90,
                    color: Color(0xFF0B5FFF),
                  ),
                ),

                const SizedBox(height: 16),

                Opacity(
                  opacity: _fadeAnim.value,
                  child: const Text(
                    'Hospital Management System',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Manage Patients, Doctors & Appointments Easily',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 24),

                if (isLoading)
                  const CircularProgressIndicator()
                else
                  const Icon(Icons.check_circle, color: Colors.green, size: 30),

                const SizedBox(height: 20),

                const Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
