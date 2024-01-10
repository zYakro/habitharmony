import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/ShopObject.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

class ShopConfirmationDialog extends StatelessWidget {
  final ShopManager shopManager = getIt<ShopManager>();
  final ShopObject shopObject;

  ShopConfirmationDialog({super.key, required this.shopObject});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(shopObject.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(
              child: Container(
                width: 50, // Ancho del cuadro
                height: 50, // Alto del cuadro
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust the value for the desired roundness
                ),
                child: shopObject.widget
              ),
            ),
            const SizedBox(height: 25.0),
            Text(shopObject.description),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Ancho del 90% del AlertDialog
                child: ElevatedButton(
                  child: Text('Buy'),
                  onPressed: () {
                    shopManager.buy(shopObject);
                    Navigator.of(context).pop(); // Cierra el modal
                  },
                ),
              ),
              SizedBox(height: 10.0), // Espacio entre botones
              Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // Ancho del 90% del AlertDialog
                child: TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el modal
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
