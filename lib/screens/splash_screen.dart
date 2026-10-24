import 'package:flutter/material.dart';
import 'package:challenge2/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToMainScreen();
  }

  Future<void> _goToMainScreen() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/cafe.jpg',
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.local_cafe,
              size: 100,
              color: Colors.brown,
            );
          },
        ),
      ),
    );
  }
}
