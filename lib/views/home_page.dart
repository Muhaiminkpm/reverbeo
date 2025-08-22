import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/view_models/auth_view_model.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (audioViewModel.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton.icon(
                icon: Icon(audioViewModel.isRecording ? Icons.stop : Icons.mic),
                label: Text(audioViewModel.isRecording ? 'Stop' : 'Record'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (audioViewModel.isRecording) {
                    final error = await audioViewModel.stopAndUploadRecording();
                    if (error != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error), backgroundColor: Colors.red),
                      );
                    }
                  } else {
                    audioViewModel.startRecording();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}