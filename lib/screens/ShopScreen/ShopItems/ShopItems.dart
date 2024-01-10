import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/screens/ShopScreen/ShopItems/ShopItem.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

class ShopItems extends StatefulWidget {
  const ShopItems({super.key});

  @override
  State<ShopItems> createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {
  ShopManager shopManager = getIt<ShopManager>();

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: shopManager.inventory,
        builder: (context, inventory, _) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView.builder(
              itemCount: shopManager.items.length,
              itemBuilder: (context, index) {
                final categoryData = shopManager.items[index];
                final categoryKey = categoryData.keys.first;
                final items = categoryData[categoryKey];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        capitalize(categoryKey),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 90,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 0,
                      ),
                      itemCount: items!.length,
                      itemBuilder: (context, subIndex) {
                        final item = items[subIndex];
                        bool isInInventory = inventory.contains(item.name);
                        
                        return GridTile(
                          child: ShopItem(shopObject: item, isInInventory: isInInventory),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          );
        });
  }
}
