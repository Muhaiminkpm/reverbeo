import 'package:flutter/material.dart';
import 'package:reverbeo/constants/app_colors.dart';

class AnimatedRecordButton extends StatefulWidget {
  final bool isRecording;
  final VoidCallback onPressed;

  const AnimatedRecordButton({
    super.key,
    required this.isRecording,
    required this.onPressed,
  });

  @override
  State<AnimatedRecordButton> createState() => _AnimatedRecordButtonState();
}

class _AnimatedRecordButtonState extends State<AnimatedRecordButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedRecordButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.value = 0.0;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: widget.isRecording ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
          child: SizedBox(
            width: 150,
            height: 150,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.isRecording ? AppColors.recordActive : AppColors.primary,
                shape: const CircleBorder(),
                elevation: 8.0,
                shadowColor: Colors.black.withOpacity(0.4),
              ),
              child: Icon(
                widget.isRecording ? Icons.stop_rounded : Icons.mic_none_rounded,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          widget.isRecording ? 'Recording...' : 'Tap to Record',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.isRecording ? AppColors.recordActive : AppColors.text,
          ),
        ),
      ],
    );
  }
}
