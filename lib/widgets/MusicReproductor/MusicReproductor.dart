import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/NextSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PlayButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PreviousSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/RepeatButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/ShuffleButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioProgressBar.dart';
import 'package:flutter_audio_service_demo/widgets/Marquee/MarqueeWidget.dart';
import 'package:flutter_audio_service_demo/widgets/MusicReproductor/PlaylistModal.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicReproductor extends StatefulWidget {
  const MusicReproductor({super.key});

  @override
  State<MusicReproductor> createState() => _MusicReproductorState();
}

class _MusicReproductorState extends State<MusicReproductor> {
  final pageManager = getIt<PageManager>();

  void showPlaylistModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const PlaylistModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          title: Center(
              child: Text(
            'Reproductor',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          )),
          leading: IconButton(
            icon: Icon(
              Icons.expand_more_rounded,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert_outlined,
                  color: Theme.of(context).iconTheme.color, size: 25),
              onPressed: () {
                // Handle the action you want when the "more_vert" icon is pressed
              },
            ),
          ],
        ),
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Artwork
                  Container(
                    width: 400,
                    height: 300,
                    child: Container(
                      width: 350,
                      height: 300,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ValueListenableBuilder<MediaItem?>(
                          valueListenable: pageManager.currentSongItemNotifier,
                          builder: (_, item, __) {
                            return QueryArtworkWidget(
                              id: int.parse(item!.id),
                              type: ArtworkType.AUDIO,
                              artworkHeight: 200,
                              artworkWidth: 200,
                              artworkBorder: BorderRadius.circular(5),
                              quality: 100,
                              artworkQuality: FilterQuality.high,
                              artworkFit: BoxFit.contain,
                              nullArtworkWidget: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.music_note,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                    child: ValueListenableBuilder<String>(
                      valueListenable: pageManager.currentSongTitleNotifier,
                      builder: (_, title, __) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              40, 0, 40, 0),
                          child: MarqueeWidget(
                            animationDuration:
                                const Duration(milliseconds: 8000),
                            backDuration: const Duration(milliseconds: 2000),
                            child: Text(title,
                                style: const TextStyle(fontSize: 25)),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 15),
                    child: ValueListenableBuilder<MediaItem?>(
                      valueListenable: pageManager.currentSongItemNotifier,
                      builder: (_, item, __) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(item?.album ?? '',
                              style: const TextStyle(fontSize: 15)),
                        );
                      },
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                    child: SizedBox(
                      width: 350,
                      height: 5,
                      child: AudioProgressBar(),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ShuffleButton(iconSize: 25),
                        PreviousSongButton(iconSize: 40),
                        const PlayButton(
                          iconSize: 80,
                          playIcon: Icons.play_circle_fill,
                          pauseIcon: Icons.pause_circle_filled,
                        ),
                        const NextSongButton(iconSize: 40),
                        const RepeatButton(iconSize: 25),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: IconButton(
                    onPressed: () {
                      showPlaylistModal(context);
                    },
                    icon: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.expand_more,
                          size: 30.0,
                        ),
                        Text('Playlist')
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}
