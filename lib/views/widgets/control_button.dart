import 'package:flutter/material.dart';
import 'package:reverbeo/constants/app_colors.dart';

class ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const ControlButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 32),
          onPressed: onPressed,
          color: AppColors.primary,
          disabledColor: Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.text)),
      ],
    );
  }
}