import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/view_models/auth_view_model.dart';
import 'package:reverbeo/views/widgets/animated_record_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final audioViewModel = Provider.of<AudioViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authViewModel.signOut(),
          ),
        ],
      ),
      body: Center(
        child: audioViewModel.isLoading
            ? const CircularProgressIndicator()
            : AnimatedRecordButton(
                isRecording: audioViewModel.isRecording,
                onPressed: () async {
                  if (audioViewModel.isRecording) {
                    final error = await audioViewModel.stopAndUploadRecording();
                    if (error != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                  } else {
                    audioViewModel.startRecording();
                  }
                },
              ),
      ),
    );
  }
}