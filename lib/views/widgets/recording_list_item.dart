import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverbeo/constants/app_colors.dart';
import 'package:reverbeo/model/audio_file.dart';

class RecordingListItem extends StatelessWidget {
  final AudioFile recording;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const RecordingListItem({
    super.key,
    required this.recording,
    required this.isPlaying,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: isPlaying ? AppColors.recordActive : AppColors.primary,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Recording #${recording.id.substring(0, 6)}', // Show a shortened ID
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd().add_jm().format(recording.timestamp),
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: AppColors.delete),
          onPressed: onDelete,
        ),
        onTap: onPlay,
      ),
    );
  }
}
