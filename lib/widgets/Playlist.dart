import "package:audio_service/audio_service.dart";
import "package:flutter/material.dart";
import "package:flutter_audio_service_demo/page_manager.dart";
import "package:flutter_audio_service_demo/services/service_locator.dart";

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<MediaItem?>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(playlistTitles[index]?.title ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
