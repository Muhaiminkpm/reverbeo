import 'package:flutter/material.dart';
import 'package:reverbeo/constants/app_colors.dart';

class RecordButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onPressed;

  const RecordButton({
    Key? key,
    required this.isRecording,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isRecording ? Colors.redAccent : AppColors.primary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
        ),
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}