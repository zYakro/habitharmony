import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/PetHeart/PetHeart.dart';
import 'package:flutter_audio_service_demo/widgets/PetMessage/PetMessage.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class PetWidget extends StatefulWidget {
  const PetWidget({super.key});

  @override
  State<PetWidget> createState() => _PetWidgetState();
}

class _PetWidgetState extends State<PetWidget> {
  PetManager petManager = getIt<PetManager>();
  @override
  Widget build(BuildContext context) {
    Widget getHeart(int petted, int index) {
      if (petted >= index) {
        return Icon(Icons.favorite,
            color: Theme.of(context).colorScheme.error, size: 30);
      }
      return Icon(Icons.favorite,
          color: Theme.of(context).colorScheme.onBackground, size: 30);
    }

    return ValueListenableBuilder(
      valueListenable: petManager.petInfo,
      builder: (context, petInfo, _) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getHeart(petInfo.petted, 1),
                    getHeart(petInfo.petted, 2)
                  ],
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const PetMessage(),
                      const SizedBox(
                        height: 15,
                      ),
                      Bounce(
                        duration: const Duration(milliseconds: 100),
                        onPressed: () {
                          petManager.getPetMessage();
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/pets/${petInfo.petFile}',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const PetHeart(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      getHeart(petInfo.petted, 3),
                      getHeart(petInfo.petted, 4)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
