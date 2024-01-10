import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class ShuffleButton extends StatelessWidget {
  final IconData shuffleIcon;
  final double iconSize;

  const ShuffleButton({
    Key? key,
    this.shuffleIcon = Icons.shuffle,
    this.iconSize = 32.0, // Default icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(shuffleIcon, size: iconSize)
              : Icon(shuffleIcon, color: Colors.grey, size: iconSize),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}