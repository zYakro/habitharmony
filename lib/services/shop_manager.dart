// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/ShopObject.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/theme/detailed_theme.dart';
import 'package:flutter_audio_service_demo/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopManager {
  final money = ValueNotifier<int>(0);
  final inventory = ValueNotifier<List<String>>(['default_theme', 'panda.png']);
  final currentTheme = 'default_theme';
  final moneyOnHabit = 15;
  final moneyOnTodo = 10;
  final PetManager petManager = getIt<PetManager>();

  final List<Map<String, List<ShopObject>>> items = [
    {
      'themes': [
        ShopObject(
            title: 'Default theme',
            name: 'default_theme',
            price: 0,
            description:
                'App default theme. A mix between synthwave and simplicity.',
            widget: const Icon(Icons.check_box_outline_blank, size: 35),
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: lightThemeData,
                dark: darkThemeData,
              );
            },
            type: 'themes'),
        ShopObject(
            title: 'Panda Theme',
            name: 'panda_theme',
            price: 60,
            description: 'A simple-looking theme, between black and white',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: pandaLightTheme,
                dark: pandaDarkTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
                border: Border.all(
                  color: const Color(0xFF000000), // Set the border color to red
                  width: 2.0, // Border width
                ),
              ),
            ),
            type: 'themes'),
        ShopObject(
            title: 'Ice Theme',
            name: 'ice_theme',
            price: 55,
            description: 'An elegant theme with blue colors',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: iceLightTheme,
                dark: iceDarkTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Color(0xFF4bcffa),
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
            ),
            type: 'themes'),
        ShopObject(
            title: 'Ruby Theme',
            name: 'ruby_theme',
            price: 35,
            description: 'An precious theme with red colors',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: rubyLightTheme,
                dark: rubyDarkTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Color(0xeFFb3b5a),
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
            ),
            type: 'themes'),
        ShopObject(
            title: 'Lavender Theme',
            name: 'lavender_theme',
            price: 45,
            description: 'An precious theme with pink colors',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: lavenderLightTheme,
                dark: lavenderDarkTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFDA7DF),
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
            ),
            type: 'themes'),
        ShopObject(
            title: 'Menta Theme',
            name: 'menta_theme',
            price: 60,
            description: 'A fresh menta theme',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: mentaLightTheme,
                dark: mentaDarkTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Color(0xFF7bed9f),
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
            ),
            type: 'themes'),
        ShopObject(
            title: 'Synthwave Theme',
            name: 'synthwave_theme',
            price: 120,
            description: 'A colorful synthwave theme to revive your 80s neon dreams!',
            function: (BuildContext context) {
              AdaptiveTheme.of(context).setTheme(
                light: synthwaveLightTheme,
                dark: synthwaveNightTheme,
              );
            },
            widget: Container(
              decoration: BoxDecoration(
                color: Color(0xFFf772e0),
                borderRadius: BorderRadius.circular(
                    5.0), // Adjust the value for the desired roundness
              ),
            ),
            type: 'themes'),
      ],
    },
    {
      'pets': [
        ShopObject(
            title: 'Panda',
            name: 'panda.png',
            price: 200,
            description: 'A playful pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/panda.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
        ShopObject(
            title: 'Beaver',
            name: 'beaver.png',
            price: 180,
            description: 'A playful pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/beaver.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
        ShopObject(
            title: 'Blue Tilapia',
            name: 'blue_tilapia.png',
            price: 250,
            description: 'A playful blue pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/blue_tilapia.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
        ShopObject(
            title: 'Red Bird',
            name: 'red_bird.png',
            price: 230,
            description: 'A playful pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/red_bird.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
        ShopObject(
            title: 'Sea Horse',
            name: 'sea_horse.png',
            price: 310,
            description: 'A playful pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/sea_horse.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
        ShopObject(
            title: 'Turtle',
            name: 'turtle.png',
            price: 350,
            description: 'A playful pet!',
            function: (context) {
              return;
            },
            widget: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pets/turtle.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            type: 'pets'),
      ],
    },
  ];

  void onShopItemFunction(ShopObject shopObject) async {
    if (shopObject.type == 'themes') {
      saveThemeToLocalStorage(shopObject.name);
      return;
    }
    if (shopObject.type == 'pets') {
      petManager.setNewPet(shopObject.name);
    }
  }

  Future<void> saveThemeToLocalStorage(String themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeName);
  }

  Future<String> getThemeFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    return (theme != null) ? theme : 'default_theme';
  }

  Future<void> saveInventoryToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('inventory', jsonEncode(inventory.value));
  }

  Future<void> getInventoryFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? inventoryString = prefs.getString('inventory');

    if (inventoryString != null) {
      final List<dynamic> decodedInventory =
          jsonDecode(inventoryString) as List<dynamic>;
      inventory.value = decodedInventory.cast<String>();
    }
  }

  Future<void> saveMoneyToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('money', money.value.toString());
  }

  Future<void> getMoneyFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final moneyString = prefs.getString('money');
    if (moneyString != null) {
      money.value = int.parse(moneyString);
    }
  }

  void applySavedTheme(context) async {
    String theme = await getThemeFromLocalStorage();

    ShopObject? foundObject = items[0]['themes']?.firstWhere(
      (item) => item.name == theme,
    );

    foundObject?.function!(context);
  }

  void addMoney(int addition) {
    money.value += addition;
    money.notifyListeners();
  }

  bool hasEnoughMoney(int moneyToCompare) {
    return (money.value >= moneyToCompare) ? true : false;
  }

  void buy(ShopObject shopObject) {
    if (!hasEnoughMoney(shopObject.price)) {
      return;
    }

    substractMoney(shopObject.price);
    inventory.value = [...inventory.value, shopObject.name];
    inventory.notifyListeners();
    saveInventoryToLocalStorage();
    saveMoneyToLocalStorage();
  }

  void substractMoney(int substract) {
    money.value -= substract;
    money.notifyListeners();
  }

  void onCompleteHabit(bool isCompleted) {
    if (isCompleted) {
      addMoney(moneyOnHabit);
    } else {
      substractMoney(moneyOnHabit);
    }
    saveMoneyToLocalStorage();
  }

  void onCompleteTodo(bool isCompleted) {
    if (isCompleted) {
      addMoney(moneyOnTodo);
    } else {
      substractMoney(moneyOnTodo);
    }
    saveMoneyToLocalStorage();
  }

  void removeOnCompleteTodo() {
    substractMoney(moneyOnTodo);
  }

  void init() {
    getInventoryFromLocalStorage();
    getMoneyFromLocalStorage();
  }
}
