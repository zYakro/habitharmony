import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

void showTaskRewardSnackbar(
    bool isCompleted, String type, BuildContext context) {
  ShopManager shopManager = getIt<ShopManager>();
  final moneySign = (isCompleted) ? "+" : "-";
  final money = (type == 'habit')
      ? "$moneySign${shopManager.moneyOnHabit}"
      : "$moneySign${shopManager.moneyOnTodo}";
  final exp = (isCompleted) ? "+5" : "-5";
  final snackColor = (isCompleted) ? Color.fromARGB(255, 97, 216, 135) : const Color(0xFFff6b81);

  final snackBar = SnackBar(
    elevation: 0,
    content: GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: SizedBox(
          width: MediaQuery.of(context)
              .size
              .width, // Ancho completo de la pantalla
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 30,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20.0), // Esquinas redondeadas
                color: snackColor, // Color de fondo del container
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.music_video,
                    size: 25.0,
                    color: Colors.white, // Icon color
                  ),
                  const SizedBox(width: 8.0),
                  Text(money,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal)),
                  const SizedBox(width: 8.0),
                  const Text('EXP ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Text('$exp',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent, // Color de fondo rojo
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
