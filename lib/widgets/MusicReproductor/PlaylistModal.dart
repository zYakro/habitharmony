import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/QueryArtwork/QueryArtwor.dart';

class PlaylistModal extends StatefulWidget {
  const PlaylistModal({super.key});

  @override
  State<PlaylistModal> createState() => _PlaylistModalState();
}

class _PlaylistModalState extends State<PlaylistModal> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Playlist',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.expand_less,
              size: 25,
              color: Theme.of(context).iconTheme.color,
            )),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: ValueListenableBuilder<List<MediaItem?>>(
            valueListenable: pageManager.playlistNotifier,
            builder: (context, playlistTitles, _) {
              return ReorderableListView(
                buildDefaultDragHandles: false,
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  // Handle the reordering logic here
                  pageManager.move(oldIndex, newIndex);
                },
                children: <Widget>[
                  for (int index = 0; index < playlistTitles.length; index++)
                    ListTile(
                        key: ValueKey<String>(playlistTitles[index]?.id ?? ''),
                        title: Text(playlistTitles[index]?.title ?? ''),
                        subtitle: Text(playlistTitles[index]?.album ?? ''),
                        tileColor: Theme.of(context).colorScheme.background,
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.menu),
                        ),
                        leading: QueryArtwork(
                          id: int.tryParse(playlistTitles[index]?.id ?? '') ?? 0,
                        ),
                        onTap: () async {
                          pageManager.skipToQueueItem(index);
                          pageManager.play();
                        }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
