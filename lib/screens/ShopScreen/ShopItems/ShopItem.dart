import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/ShopObject.dart';
import 'package:flutter_audio_service_demo/screens/ShopScreen/ShopConfirmationDialog/ShopConfirmationDialog.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

class ShopItem extends StatelessWidget {
  final ShopManager shopManager = getIt<ShopManager>();
  final ShopObject shopObject;
  final bool isInInventory;

  ShopItem(
      {super.key, required this.shopObject, required this.isInInventory});

  bool isAnyObjectFound(List<ShopObject> itemList, List<String> titlesToFind) {
    // Use `any` to check if any title in `titlesToFind` exists in `itemList`
    return titlesToFind.any((name) {
      return itemList.any((item) => item.name == name);
    });
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ShopConfirmationDialog(
            shopObject:
                shopObject // Pasa la función de acción de compra como parámetro
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isInInventory) {
          _showConfirmationDialog(context);
          return;
        }
        shopObject.function!(context);
        shopManager.onShopItemFunction(shopObject); 
      },
      child: Card(
        color: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.0, // Ancho del cuadro
              height: 50.0, // Alto del cuadro
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
              child: shopObject.widget,
            ),
            const SizedBox(height: 5.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: !isInInventory ? [
                  Icon(
                    Icons.local_atm_outlined, // Icono de carrito de compras
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 18,
                  ),
                  Text(
                    shopObject.price.toString(), // Precio del elemento
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] : []),
          ],
        ),
      ),
    );
  }
}
