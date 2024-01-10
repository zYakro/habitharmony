import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Habit.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/playlist_repository.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSong extends StatefulWidget {
  final Habit habit;

  const AddSong({super.key, required this.habit});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  HabitsManager habitManager = getIt<HabitsManager>();
  PlaylistRepository playlistRepository = getIt<PlaylistRepository>();
  List<SongModel>? songs;
  ValueNotifier<List<SongModel>> filteredSongsNotifier =
      ValueNotifier<List<SongModel>>([]);
  List<String> songsToAdd = [];

  @override
  void initState() {
    fetchSongs();

    songsToAdd = List.from(widget.habit.playlist);

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
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterSongs,
                decoration: InputDecoration(
                  labelText: 'Search songs',
                  hintText: 'Enter song title',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add_to_photos_rounded),
                    onPressed: () {
                      habitManager.rewriteHabitPlaylist(
                          widget.habit, songsToAdd);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
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
                        // If the song's uri is found in the current playlist or the new added playlist
                        bool isSongInPlaylist =
                            songsToAdd.contains(filteredSongs[index].uri);

                        return ListTile(
                          title: Text(
                            filteredSongs[index].title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(filteredSongs[index].album ?? '',
                              style: Theme.of(context).textTheme.bodySmall),
                          leading: Container(
                            width: 90,
                            height: 80,
                            child: Row(
                              children: [
                                Icon(
                                  isSongInPlaylist
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                ),
                                const SizedBox(width: 10),
                                QueryArtworkWidget(
                                  id: filteredSongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder:
                                      const BorderRadius.horizontal(),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            isSongInPlaylist =
                                songsToAdd.contains(filteredSongs[index].uri);

                            if (isSongInPlaylist) {
                              // remove
                              songsToAdd
                                  .remove(filteredSongs[index].uri as String);
                            } else {
                              // add
                              songsToAdd
                                  .add(filteredSongs[index].uri as String);
                            }

                            setState(() {
                              isSongInPlaylist =
                                  songsToAdd.contains(filteredSongs[index].uri);
                            });
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
