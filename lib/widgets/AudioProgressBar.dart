
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/notifiers/progress_notifier.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
          baseBarColor: Theme.of(context).disabledColor,
          barHeight: 2,
          progressBarColor: Theme.of(context).primaryColor,
          bufferedBarColor: const Color(0x00FFFFFF), // Transparent
          thumbColor: Theme.of(context).primaryColor,
        );
      },
    );
  }
}