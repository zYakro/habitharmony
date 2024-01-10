import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/playlist_repository.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchSongs extends StatefulWidget {
  const SearchSongs({super.key});

  @override
  State<SearchSongs> createState() => _SearchSongsState();
}

class _SearchSongsState extends State<SearchSongs> {
  PageManager pageManager = getIt<PageManager>();
  PlaylistRepository playlistRepository = getIt<PlaylistRepository>();
  List<SongModel>? songs;
  ValueNotifier<List<SongModel>> filteredSongsNotifier =
      ValueNotifier<List<SongModel>>([]);

  @override
  void initState() {
    fetchSongs();

    super.initState();
  }

  void fetchSongs() async {
    songs = playlistRepository.songListNotifier.value;
    filteredSongsNotifier.value = songs!;
  }

  void filterSongs(String searchText) {
    filteredSongsNotifier.value = songs!
        .where((song) =>
            song.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterSongs,
              decoration: const InputDecoration(
                labelText: 'Search songs',
                hintText: 'Enter song title',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: playlistRepository.fetchAllSongs,
              child: ValueListenableBuilder<List<SongModel>>(
                valueListenable: filteredSongsNotifier,
                builder: (context, filteredSongs, child) {
                  if (filteredSongs.isEmpty) {
                    return const Center(
                      child: Text('No songs found'),
                    );
                  } else if (filteredSongs.isEmpty) {
                    return const Center(
                      child: Text("No Songs Found"),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredSongs.length,
                      itemBuilder: (context, index) {
                        // Build your list items using filteredSongs here
                        return ListTile(
                          title: Text(
                            filteredSongs[index].title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(filteredSongs[index].album ?? '',
                              style: Theme.of(context).textTheme.bodySmall),
                          trailing: const Icon(Icons.more_vert),
                          leading: QueryArtworkWidget(
                            id: filteredSongs[index].id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: const BorderRadius.horizontal(),
                          ),
                          onTap: () async {
                            int songIndex = songs!.indexWhere(
                                (song) => song.id == filteredSongs[index].id);

                            await pageManager.rewritePlaylist(songs!);
                            pageManager.skipToQueueItem(songIndex);
                            pageManager.play();

                            Navigator.pop(context);
                          },
                          tileColor: Theme.of(context).colorScheme.background,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
