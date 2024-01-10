import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class PetHeart extends StatefulWidget {
  const PetHeart({super.key});

  @override
  State<PetHeart> createState() => _PetHeartState();
}

class _PetHeartState extends State<PetHeart> {
  PetManager petManager = getIt<PetManager>();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ValueListenableBuilder(
        valueListenable: petManager.petInfo,
        builder: (context, petInfo, _) {
          return Bounce(
              duration: const Duration(milliseconds: 100),
              onPressed: () {
                petManager.getPetted();
              },
              child: Container(
                  width: 50, // Adjust the size as needed
                  height: 50, // Adjust the size as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor, width: 2.0),
                  ),
                  child: Icon(Icons.favorite,
                      size: 25,
                      color: (petManager.canGetPetted())
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onBackground)));
        });
  }
}
