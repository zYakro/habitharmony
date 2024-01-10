import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

class Money extends StatefulWidget {
  const Money({super.key});

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  ShopManager shopManager = getIt<ShopManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: shopManager.money,
        builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.music_video,
                  size: 25.0,
                  color: Theme.of(context).colorScheme.tertiary, // Icon color
                ),
                const SizedBox(width: 5.0),
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.tertiary, // Text color
                  ),
                ),
              ],
            ),
          );
        });
  }
}
