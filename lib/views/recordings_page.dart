import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverbeo/view_models/audio_view_model.dart';
import 'package:reverbeo/views/widgets/recording_list_item.dart';

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
      appBar: AppBar(
        title: const Text('My Recordings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: audioViewModel.isLoading && audioViewModel.recordings.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => audioViewModel.fetchRecordings(),
              child: audioViewModel.recordings.isEmpty
                  ? const Center(
                      child: Text(
                        'No recordings yet.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: audioViewModel.recordings.length,
                      itemBuilder: (context, index) {
                        final recording = audioViewModel.recordings[index];
                        final isPlaying = audioViewModel.currentlyPlayingId == recording.id;
                        return RecordingListItem(
                          recording: recording,
                          isPlaying: isPlaying,
                          onPlay: () => audioViewModel.playRecording(recording),
                          onDelete: () => audioViewModel.deleteRecording(recording),
                        );
                      },
                    ),
            ),
    );
  }
}