import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/Money/Money.dart';
import 'package:flutter_audio_service_demo/widgets/PetStats/PetName.dart';

class PetStats extends StatefulWidget {
  const PetStats({super.key});

  @override
  State<PetStats> createState() => _PetStatsState();
}

class _PetStatsState extends State<PetStats> {
  PetManager petManager = getIt<PetManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: petManager.petInfo,
        builder: (context, petInfo, _) {
          Widget getHeart(int petted, int index) {
            if (petted >= index) {
              return Icon(Icons.favorite,
                  color: Theme.of(context).colorScheme.error, size: 20);
            }
            return Icon(Icons.favorite,
                color: Theme.of(context).colorScheme.onBackground, size: 20);
          }

          return Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      'assets/images/pets/${petInfo.petFile}', // Ruta de la imagen de la mascota
                      width: 45,
                      height: 45,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            child: const PetName(),
                          ),
                          Row(
                            children: [
                              Text(
                                'LVL ${petInfo.petLevel}', // Nivel de la mascota
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                  width: 100,
                                  child: LinearProgressIndicator(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    value: petInfo.petExp /
                                        (petInfo.petLevel * 25),
                                    minHeight: 10,
                                    backgroundColor:
                                        Theme.of(context).disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            getHeart(petInfo.petted, 1),
                            getHeart(petInfo.petted, 2),
                            getHeart(petInfo.petted, 3),
                            getHeart(petInfo.petted, 4),
                          ],
                        ),
                        const Money(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
