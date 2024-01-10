import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class PreviousSongButton extends StatelessWidget {
  final double iconSize;
  final IconData iconName;

  PreviousSongButton({Key? key, this.iconSize = 32, this.iconName = Icons.skip_previous})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          iconSize: iconSize, // Use the iconSize from the constructor
          icon: Icon(iconName), // Use the iconName from the constructor
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}