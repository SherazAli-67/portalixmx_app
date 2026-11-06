import 'package:flutter/material.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Icon(icon ?? Icons.inbox_outlined, size: 40, color: Colors.white),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.tileSubtitleTextStyle.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
