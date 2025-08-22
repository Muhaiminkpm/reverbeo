import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({super.key});

  @override
  State<RecordingsPage> createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch recordings when the page is first loaded
    Future.microtask(() => Provider.of<AudioViewModel>(context, listen: false).fetchRecordings());
  }

  @override
  Widget build(BuildContext context) {
    final audioViewModel = Provider.of<AudioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Recordings')),
      body: audioViewModel.isLoading && audioViewModel.recordings.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => audioViewModel.fetchRecordings(),
              child: audioViewModel.recordings.isEmpty
                  ? const Center(child: Text('No recordings found.'))
                  : ListView.builder(
                      itemCount: audioViewModel.recordings.length,
                      itemBuilder: (context, index) {
                        final recording = audioViewModel.recordings[index];
                        return ListTile(
                          leading: const Icon(Icons.music_note),
                          title: Text('Recording ${recording.timestamp.toIso8601String()}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () => audioViewModel.playRecording(recording),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => audioViewModel.deleteRecording(recording),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}