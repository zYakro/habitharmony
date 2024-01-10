
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/notifiers/repeat_button_notifier.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class RepeatButton extends StatelessWidget {
  final IconData repeatIcon;
  final IconData repeatOneIcon;
  final double iconSize;

  const RepeatButton({
    Key? key,
    this.repeatIcon = Icons.repeat,
    this.repeatOneIcon = Icons.repeat_one,
    this.iconSize = 32.0, // Default icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(repeatIcon, color: Colors.grey, size: iconSize);
            break;
          case RepeatState.repeatSong:
            icon = Icon(repeatOneIcon, size: iconSize);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(repeatIcon, size: iconSize);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

