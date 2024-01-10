// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetManager {
  final petInfo = ValueNotifier<Pet>(Pet(
    petName: 'Pet',
    petExp: 0,
    petLevel: 1,
    petted: 4,
    lastTimePetted: DateTime.now(),
    petFile: 'panda.png',
  ));
  final petMessage = ValueNotifier<String>('Grr (You are doing awesome!)');

  Future<void> savePetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> serializedPet = petInfo.value.toJson();
    final String petString = jsonEncode(serializedPet);
    await prefs.setString('pet', petString);
  }

  Future<void> loadPetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? petString = prefs.getString('pet');

    if (petString != null) {
      final Map<String, dynamic> decodedPet =
          jsonDecode(petString) as Map<String, dynamic>;
      petInfo.value = Pet.fromJson(decodedPet);
      return;
    }
  }

  void setPetMessage(String message) {
    petMessage.value = message;
    petMessage.notifyListeners();
  }

  int expForNextLevel(){
    return petInfo.value.petLevel * 25;
  }

  void addExp(){
    petInfo.value.petExp += 5;

    // If can level up
    if(petInfo.value.petExp >= expForNextLevel()){
      petInfo.value.petExp -= expForNextLevel();
      petInfo.value.petLevel += 1;
    }

    petInfo.notifyListeners();
    savePetInfo();
  }

  void setPetName(String newName){
    petInfo.value.petName = newName;
    petInfo.notifyListeners();
    savePetInfo();
  }
  
  void substractExp(){
    petInfo.value.petExp -= 5;

    if(petInfo.value.petExp < 0 && petInfo.value.petLevel <= 1){
      petInfo.value.petExp = 0;
    }
    else if(petInfo.value.petExp < 0){
      petInfo.value.petLevel -= 1;
      petInfo.value.petExp += expForNextLevel();
    }

    petInfo.notifyListeners();
    savePetInfo();
  }

  void setExp(bool isCompleted){
    if(isCompleted){
      return addExp();
    }
    return substractExp();
  }

  void setNewPet(String newPet) {
    petInfo.value.petFile = newPet;
    petInfo.notifyListeners();
    savePetInfo();
  }

  void getPetMessage() {
    String getRandomMessage(List<String> messages) {
      final random = Random();
      final randomIndex = random.nextInt(messages.length);
      return messages[randomIndex];
    }

    final List<String> messages = [
      "You're doing awesome!",
      "Keep trying!",
      "Perseverance is the key, keep trying!",
      "I'm proud of you, keep trying!",
      "There's not limit for you efforts!"
    ];

    if (canGetPetted()) {
      setPetMessage('Grr... (I want to get petted!)');
      return;
    }

    String randomMessage = getRandomMessage(messages);

    setPetMessage('Grr... ($randomMessage)');
  }

  bool canGetPetted() {
    if (petInfo.value.petted == 4) {
      return false;
    }

    DateTime now = DateTime.now();
    Duration difference = now.difference(petInfo.value.lastTimePetted);

    if (difference.inHours >= 2) {
      return true;
    }
    return false;
  }

  bool getPetted() {
    if (canGetPetted()) {
      petInfo.value.petted++;
      petInfo.value.lastTimePetted = DateTime.now();
      petInfo.notifyListeners();
      setPetMessage('Grr... (Feels good!)');
      savePetInfo();
      return true;
    }

    setPetMessage(
        'Grr... (I don\'t need to be petted right now, maybe later!)');
    petInfo.notifyListeners();
    return false;
  }

  void checkForPet() {
    DateTime now = DateTime.now();
    Duration lastTimePettedDifferente =
        now.difference(petInfo.value.lastTimePetted);

    int pettedHours = lastTimePettedDifferente.inHours;
    if (pettedHours >= 4) {
      pettedHours = (pettedHours / 4).floor();
      petInfo.value.petted -= min(pettedHours, 4);
    }

    petInfo.notifyListeners();
    savePetInfo();
  }

  void init() async {
    await loadPetInfo();
    checkForPet();
    getPetMessage();
  }
}
