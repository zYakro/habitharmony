import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/screens/MusicScreen/SearchSongs/SearchSongs.dart';
import 'package:flutter_audio_service_demo/screens/MusicScreen/SongList/SongList.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with AutomaticKeepAliveClientMixin<MusicScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final pageManager = getIt<PageManager>();

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsRequest();

      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }

      setState(() {});
    }
  }

  void showSongSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SearchSongs();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Music',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: IconButton(
              icon: Icon(Icons.music_note,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                icon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  showSongSearchModal(context);
                },
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
        ),
        body: const SongList());
  }

  @override
  bool get wantKeepAlive => true;
}
