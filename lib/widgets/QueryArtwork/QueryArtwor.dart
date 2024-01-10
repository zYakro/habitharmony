import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class QueryArtwork extends StatefulWidget {
  int id;

  QueryArtwork({super.key, required this.id});

  @override
  State<QueryArtwork> createState() => _QueryArtworkState();
}

class _QueryArtworkState extends State<QueryArtwork> {
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: widget.id,
      type: ArtworkType.AUDIO,
      artworkBorder: BorderRadius.circular(5),
      nullArtworkWidget: SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.music_note,
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
