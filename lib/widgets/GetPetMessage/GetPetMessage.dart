import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class GetPetMessage extends StatefulWidget {
  const GetPetMessage({super.key});

  @override
  State<GetPetMessage> createState() => _GetPetMessageState();
}

class _GetPetMessageState extends State<GetPetMessage> {
  PetManager petManager = getIt<PetManager>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          petManager.getPetMessage();
        },
        icon: Icon(Icons.phone_in_talk_rounded,
            color: Theme.of(context).colorScheme.onBackground));
  }
}
