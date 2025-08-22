import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/auth_view_model.dart';
import 'package:reverbeo/views/login_page.dart';
import 'package:reverbeo/views/main_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return StreamBuilder(
      stream: authViewModel.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && authViewModel.currentUser != null) {
          return const MainScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}