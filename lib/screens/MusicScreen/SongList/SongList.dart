import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/playlist_repository.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/QueryArtwork/QueryArtwor.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  PageManager pageManager = getIt<PageManager>();
  PlaylistRepository playlistRepository = getIt<PlaylistRepository>();
  List<SongModel>? songs;
  late List<SongModel>? filteredSongs;

  @override
  Widget build(BuildContext context) {
    return 
    ValueListenableBuilder<List<SongModel>>(
      valueListenable: playlistRepository.songListNotifier,
      builder: (context, songs, child) {
        // No songs found
        if (songs.isEmpty) {
          return const Center(
            child: Text("No Songs Found"),
          );
        }

        return RefreshIndicator(
            onRefresh: playlistRepository.fetchAllSongs,
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];

                return ListTile(
                  key: ValueKey<String>(song.id.toString()),
                  title: Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    song.album ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  tileColor: Theme.of(context).colorScheme.background,
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).iconTheme.color
                      ),
                  ),
                  leading: QueryArtwork(id: song.id),
                  onTap: () async {
                    await pageManager.rewritePlaylist(songs);
                    pageManager.skipToQueueItem(index);
                    pageManager.play();
                  },
                );
              },
            ));
      },
    );
  }
}
