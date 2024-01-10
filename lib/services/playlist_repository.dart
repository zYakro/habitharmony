import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistRepository {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  final songListNotifier = ValueNotifier<List<SongModel>>([]);

  requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsRequest();

      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
    }
  }

  Future<List<Map<String, String>>> fetchAllSongs() async {
    await requestStoragePermission();
    // Fetch all songs from the device
    List<SongModel> songs = await _onAudioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);

    songListNotifier.value = songs;

    // Take the first 'length' songs and map them to the desired format
    return songs.map((song) {
      return {
        'id': song.id.toString(),
        'title': song.title,
        'album': song.album ?? '',
        'url': song.uri ?? '',
      };
    }).toList();
  }
}
