import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/NextSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PlayButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/PreviousSongButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/RepeatButton.dart';
import 'package:flutter_audio_service_demo/widgets/AudioControlButtons/ShuffleButton.dart';

class AudioControlButtons extends StatelessWidget{
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}