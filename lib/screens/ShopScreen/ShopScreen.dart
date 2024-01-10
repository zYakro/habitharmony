import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/screens/ShopScreen/ShopItems/ShopItems.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/ThemeModeIcon/ThemeModeIcon.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  PetManager petManager = getIt<PetManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: ThemeModeIcon()),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [Expanded(child: ShopItems())],
          ),
        ),
      ),
    );
  }
}
