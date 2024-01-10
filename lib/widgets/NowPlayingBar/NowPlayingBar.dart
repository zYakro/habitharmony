import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/page_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/NextSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PlayButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PreviousSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/Marquee/MarqueeWidget.dart';
import 'package:flutter_audio_service_demo/widgets/MusicReproductor/MusicReproductor.dart';
import 'package:flutter_audio_service_demo/widgets/QueryArtwork/QueryArtwor.dart';

class NowPlayingBar extends StatefulWidget {
  const NowPlayingBar({super.key});

  @override
  State<NowPlayingBar> createState() => _NowPlayingBarState();
}

class _NowPlayingBarState extends State<NowPlayingBar> {
  final pageManager = getIt<PageManager>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Set this to true to make it fullscreen
          useSafeArea: true,
          builder: (BuildContext context) {
            return const MusicReproductor();
          },
        );
      },
      child: Container(
        height: 60,
        color: Theme.of(context)
            .colorScheme
            .surface, // Background color of the bar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Song image
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: ValueListenableBuilder<MediaItem?>(
                  valueListenable: pageManager.currentSongItemNotifier,
                  builder: (_, item, __) {
                    return QueryArtwork(
                      id: int.parse(item!.id),
                    );
                  },
                ),
              ),
              // Song details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ValueListenableBuilder<String>(
                    valueListenable: pageManager.currentSongTitleNotifier,
                    builder: (_, title, __) {
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: MarqueeWidget(
                          animationDuration: const Duration(milliseconds: 7000),
                          backDuration: const Duration(milliseconds: 1000),
                          child:
                              Text(title, style: const TextStyle(fontSize: 15)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Control buttons
              Row(
                children: [
                  PreviousSongButton(),
                  PlayButton(),
                  NextSongButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
