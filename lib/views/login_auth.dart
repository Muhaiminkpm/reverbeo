
import 'package:biometric_auth_flutter/biometric_auth_flutter.dart';
import 'package:flutter/material.dart';
import 'package:reverbeo/views/home_page.dart';

class Login_Auth extends StatefulWidget {
  const Login_Auth({super.key});

  @override
  State<Login_Auth> createState() => _Login_AuthState();
}

class _Login_AuthState extends State<Login_Auth> {
 final _biometric = BiometricAuthFlutter();

  @override
  void initState() {
    super.initState();
    _authenticateUser();
  }

  Future<void> _authenticateUser() async {
    final success = await _biometric.authenticate();
    if (success) {
      // Navigate to home page or next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      // Optional: Show error or keep trying
      debugPrint('Biometric auth failed or canceled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}