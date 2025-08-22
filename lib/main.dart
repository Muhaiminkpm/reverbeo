import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/view_models/auth_view_model.dart';
import 'package:reverbeo/views/splash_screen.dart';
import 'package:reverbeo/constants/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yaygslwrbyfddsexctia.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlheWdzbHdyYnlmZGRzZXhjdGlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4NDMwNzMsImV4cCI6MjA3MTQxOTA3M30.qRb4NTL6tSJgLNTiqN0GQLa1g4fCVGmGcCGDPi7FohU',
  );

  runApp(const ReverbeoApp());
}

class ReverbeoApp extends StatelessWidget {
  const ReverbeoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => AudioViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reverbeo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}