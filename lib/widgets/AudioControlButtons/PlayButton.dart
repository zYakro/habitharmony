import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/notifiers/play_button_notifier.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class PlayButton extends StatelessWidget {
  final IconData playIcon;
  final IconData pauseIcon;
  final double iconSize;

  const PlayButton({
    Key? key,
    this.playIcon = Icons.play_arrow,
    this.pauseIcon = Icons.pause,
    this.iconSize = 32.0, // Default icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: iconSize,
              height: iconSize,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(playIcon),
              iconSize: iconSize, // Use the custom icon size
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(pauseIcon),
              iconSize: iconSize, // Use the custom icon size
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}