import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/playlist_repository.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class FirstArtwork extends StatefulWidget {
  List<String> playlist;

  FirstArtwork({super.key, required this.playlist});

  @override
  State<FirstArtwork> createState() => _FirstArtworkState();
}

class _FirstArtworkState extends State<FirstArtwork> {
  PlaylistRepository playlistRepository = getIt<PlaylistRepository>();

  @override
  Widget build(BuildContext context) {
    if (widget.playlist.isEmpty) {
      // Return an empty container if the playlist is empty.
      return Container(
          width: 200,
          height: 200,
          child: Icon(
            Icons.library_music_sharp,
            color: Theme.of(context).colorScheme.onBackground,
            size: 150,
          ));
    } else {
      // Find the song if the playlist is not empty.
      SongModel foundSong =
          playlistRepository.songListNotifier.value.firstWhere(
        (song) => song.uri == widget.playlist[0],
      );

      return Container(
        width: 200,
        height: 200,
        child: QueryArtworkWidget(
          id: foundSong.id,
          type: ArtworkType.AUDIO,
          artworkHeight: 200,
          artworkWidth: 200,
          artworkBorder: BorderRadius.circular(5),
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: SizedBox(
              width: 200,
              height: 200,
              child: Icon(
                Icons.music_note,
                color: Theme.of(context).primaryColor,
                size: 200,
              )),
        ),
      );
    }
  }
}
