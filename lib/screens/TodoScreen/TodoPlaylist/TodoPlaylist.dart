import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Todo.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/AddSong/AddSong.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/playlist_repository.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TodoPlaylist extends StatefulWidget {
  final Todo todo;

  const TodoPlaylist({super.key, required this.todo});

  @override
  State<TodoPlaylist> createState() => _TodoPlaylistState();
}

class _TodoPlaylistState extends State<TodoPlaylist> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  PageManager pageManager = getIt<PageManager>();
  PlaylistRepository playlistRepository = getIt<PlaylistRepository>();
  late List<SongModel> filteredSongs;

  void updateFilteredSongs() {
    filteredSongs = widget.todo.playlist
        .map((uri) => playlistRepository.songListNotifier.value.firstWhere(
              (song) => song.uri == uri,
            ))
        .toList();
  }

  void showAddSongModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AddSong(todo: widget.todo);
      },
    );
  }

  void playSong(int index) async {
    await pageManager.rewritePlaylist(filteredSongs);
    pageManager.skipToQueueItem(index);
    pageManager.play();
  }

  void playPlaylist() async {
    await pageManager.rewritePlaylist(filteredSongs);
    pageManager.skipToQueueItem(0);
    pageManager.play();
  }

  void shuffleSong() async {
    await pageManager.rewritePlaylist(filteredSongs);
    pageManager.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.add_circle,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              showAddSongModal(context);
            },
          ),
          actions: [
            IconButton(
              icon:
                  Icon(Icons.shuffle, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                shuffleSong();
              },
            ),
            IconButton(
              icon: Icon(Icons.play_circle,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                playPlaylist();
              },
            ),
          ],
        ),
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }

                habitsManager.reorderTodoPlaylist(
                    widget.todo, oldIndex, newIndex);
              },
              itemCount: widget.todo.playlist.length,
              itemBuilder: (context, index) {
                updateFilteredSongs();

                SongModel song = filteredSongs[index];

                return ListTile(
                  key: ValueKey<int>(song.id),
                  title: Text(song.title),
                  subtitle: Text(song.album ?? ''),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.menu),
                  ),
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: const BorderRadius.horizontal(),
                  ),
                  onTap: () async {
                    playSong(index);
                  },
                );
              },
            )));
  }
}

