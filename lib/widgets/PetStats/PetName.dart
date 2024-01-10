import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class PetName extends StatefulWidget {
  const PetName({super.key});

  @override
  State<PetName> createState() => _PetNameState();
}

class _PetNameState extends State<PetName> {
  PetManager petManager = getIt<PetManager>();
  late TextEditingController _petNameController;
  bool _isFocused = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updatePetName() {
      petManager.setPetName(_petNameController.text);
      FocusManager.instance.primaryFocus?.unfocus();
    }

    return ValueListenableBuilder(
        valueListenable: petManager.petInfo,
        builder: (context, petInfo, _) {
          _petNameController =
              TextEditingController(text: petManager.petInfo.value.petName);
          return WillPopScope(
              onWillPop: () async {
                updatePetName();
                return true;
              },
              child: TextFormField(
                onTapOutside: (event) {
                  if (_isFocused) {
                    updatePetName();
                    setState(() {
                      _isFocused = false;
                    });
                  }
                },
                onTap: () {
                  setState(() {
                    _isFocused = true;
                  });
                },
                onFieldSubmitted: (text) {
                  updatePetName();
                  setState(() {
                    _isFocused = false;
                  });
                },
                controller: _petNameController,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // Remove border
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false, // Remove background color
                ),
                textAlignVertical: TextAlignVertical.center,
              ));
        });
  }
}
