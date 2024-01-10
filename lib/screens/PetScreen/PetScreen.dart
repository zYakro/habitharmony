import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/screens/PetScreen/PetWidget/PetWidget.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  PetManager petManager = getIt<PetManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pet',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            icon: Icon(Icons.pets, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
            children: [
              PetWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
