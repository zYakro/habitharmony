import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: const TextStyle(fontSize: 40)),
        );
      },
    );
  }
}