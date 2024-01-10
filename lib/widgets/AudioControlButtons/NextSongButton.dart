import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class NextSongButton extends StatelessWidget {
  final IconData iconName;
  final double iconSize;

  const NextSongButton({
    Key? key,
    this.iconName = Icons.skip_next,
    this.iconSize = 32.0, // Default icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          iconSize: iconSize, // Use the iconSize from the constructor
          icon: Icon(iconName), // Use custom iconName and iconSize
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}