import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class PetMessage extends StatefulWidget {
  const PetMessage({super.key});

  @override
  State<PetMessage> createState() => _PetMessageState();
}

class _PetMessageState extends State<PetMessage> {
  PetManager petManager = getIt<PetManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: petManager.petMessage,
        builder: (context, message, child) {
          return Container(
            width: 200,
            height: 50,
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18),
          ));
        });
  }
}
